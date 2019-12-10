import React, { Component } from "react";
import { BrowserRouter, Route } from "react-router-dom";
import classnames from "classnames";
import _ from "lodash";
import { HeaderBar } from "./lib/header-bar.js";
import { store } from "/store";

export class Root extends Component {
  constructor(props) {
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
  }

  select(key) {
    store.handleEvent({ data: { local: { selectedArm: key } } });
  }

  render() {
    const selected = this.state.inbox[this.state.selectedArm];
    return (
      <BrowserRouter>
        <div>
          <HeaderBar />
          <Route
            exact
            path="/~browser"
            render={() => {
              return (
                <div className="pa3 w-100">
                  <h1 className="mt0 f2">browser</h1>
                  <div className="flex">
                    <div className="flex-col">
                      {_.map(this.state.inbox, (value, key) => (
                        <div onClick={() => this.select(key)} key={key}>
                          {key}
                        </div>
                      ))}
                    </div>
                    <code className="flex-grow">{selected}</code>
                  </div>

                  <p className="lh-copy measure pt3">
                    Welcome to your Landscape application.
                  </p>
                  <p className="lh-copy measure pt3">
                    To get started, edit <code>src/index.js</code> or{" "}
                    <code>browser.hoon</code> and <code>|commit %home</code> on
                    your Urbit ship to see your changes.
                  </p>
                  <a
                    className="black no-underline db body-large pt3"
                    href="https://urbit.org/docs"
                  >
                    -> Read the docs
                  </a>
                </div>
              );
            }}
          />
        </div>
      </BrowserRouter>
    );
  }
}
