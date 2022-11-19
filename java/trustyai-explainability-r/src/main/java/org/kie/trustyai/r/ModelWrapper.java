package org.kie.trustyai.r;

import org.rosuda.REngine.*;

public class ModelWrapper {

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

}
