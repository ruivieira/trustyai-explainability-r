package org.kie.trustyai.r;

import org.rosuda.REngine.*;

public class ModelWrapper {

    public static REXP call(REXPReference fn) throws REngineException, REXPMismatchException {
        return fn.getEngine().eval(new REXPLanguage(new RList(new REXP[]{fn})), null, false);
    }
}
