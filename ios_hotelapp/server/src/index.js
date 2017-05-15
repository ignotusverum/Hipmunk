import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import './index.css';

import { bindJSNamespace, messageSenders} from './jsAPI';


/**
 * React component with super basic application state management.
 * When mounted, sets `namespaceHost[namespace]` to the object
 * specified in jsAPI.js.
 * 
 * For example, if you mount it like this:
 * 
 * ```
 * <HotelAppWithAPI namespaceHost={window} namespace="JSAPI" />
 * ```
 * 
 * Then this function will be available:
 * 
 * ```
 * window.JSAPI.runHotelSearch({
 *    location: "San Francisco",
 *    dateStart: "2017-12-01",
 *    dateEnd: "2017-12-05",
 * });
 * ```
 * 
 * See `jsAPI.js` for the complete API.
 */
class HotelAppWithAPI extends Component {
  constructor() {
    super();
    this.state = {
    };
  }

  componentDidMount() {
    if (this.props.namespaceHost[this.props.namespace]) {
      throw new Error("This namespace is already populated!")
    }

    // All the public jsAPI.js functions take a `setState()` callaback as their
    // first arg. When we populate the namespace, we bind this argument automatically
    // so that when you call the public function, it already knows how to update
    // the UI. For example,
    // `runHotelSearch(setState, {args})`
    // becomes
    // `window.HybridPages.runHotelSearch({args})`
    // and, when called, will update the state of this component instance.
    bindJSNamespace(this.props.namespaceHost, this.props.namespace, (newState) => {
      console.debug("State change:", newState);
      this.setState(newState);
    });

    // Tell the iOS host that it can start calling JS functions
    messageSenders.API_READY(this.props.namespace);
  }

  render() {
    // Pass all state along to the App component. All children are pure components:
    // all props, no state
    return <App {...this.state} />;
  }
}
HotelAppWithAPI.propTypes = {
  'namespaceHost': PropTypes.object.isRequired,
  'namespace': PropTypes.string.isRequired,
};


ReactDOM.render(
  <HotelAppWithAPI namespaceHost={window} namespace='JSAPI' />,
  document.getElementById('root')
);
