import _ from "lodash";

export class LocalReducer {
  reduce(json, state) {
    console.log(json);
    let data = _.get(json, "local", false);
    if (data) {
      this.selectArm(data, state);
    }
  }

  selectArm(obj, state) {
    let data = _.has(obj, "selectedArm", false);
    if (data) {
      state.selectedArm = obj.selectedArm;
    }
  }
}
