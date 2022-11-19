package org.kie.trustyai.r;

import org.kie.trustyai.explainability.model.Output;
import org.kie.trustyai.explainability.model.Type;
import org.kie.trustyai.explainability.model.Value;

public class OutputFactory {

    public static Output newNumericOutput(String name, Double value, Double score) {
        return new Output(name, Type.NUMBER, new Value(value), score);
    }
}
