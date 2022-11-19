package org.kie.trustyai.r;

import org.kie.trustyai.explainability.model.*;
import org.rosuda.REngine.*;

import java.util.List;
import java.util.concurrent.CompletableFuture;

public class ModelWrapper implements PredictionProvider {

    private final REXPReference fn;

    private ModelWrapper(REXPReference fn) {
        this.fn = fn;
    }

    public static REXP call(REXPReference fn) throws REngineException, REXPMismatchException {
        return fn.getEngine().eval(new REXPLanguage(new RList(new REXP[]{fn})), null, false);
    }

    public static String debug(REXPReference fn) throws REngineException, REXPMismatchException {
        return fn.getEngine().toString();
    }

    public static double invoke(REXPReference fn) throws REngineException, REXPMismatchException {
        REXP[] contents = new REXP[]{new REXPDouble(20.0), new REXPDouble(100.0)};
        String[] names = new String[]{"Girth", "Height"};
        RList list = new RList(contents, names);
        return fn.getEngine().eval(new REXPLanguage(new RList(new REXP[]{fn, REXP.createDataFrame(list)})) ,  null, false).asDouble();
    }

    public static ModelWrapper create(REXPReference fn) {
        return new ModelWrapper(fn);
    }

    @Override
    public CompletableFuture<List<PredictionOutput>> predictAsync(List<PredictionInput> list) {
        List<Feature> features = list.get(0).getFeatures();
        System.out.println("I got " + features.size() + " features.");
        final REXP[] values = features.stream().map(f -> new REXPDouble(f.getValue().asNumber())).toArray(REXP[]::new);
        final String[] names = features.stream().map(Feature::getName).toArray(String[]::new);
        try {
            final REXP df = REXP.createDataFrame(new RList(values, names));
            final double prediction = fn.getEngine().eval(new REXPLanguage(new RList(new REXP[]{fn, df})) ,  null, false).asDouble();
            List<Output> outputs = List.of(new Output("output", Type.NUMBER, new Value(prediction), 0.0));
            return CompletableFuture.completedFuture(List.of(new PredictionOutput(outputs)));
        } catch (REXPMismatchException | REngineException e) {
            throw new RuntimeException(e);
        }
    }
}
