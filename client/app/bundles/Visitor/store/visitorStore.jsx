import { createStore, applyMiddleware, compose } from 'redux';
import thunkMiddleware from 'redux-thunk';
import visitorReducer from '../reducer/visitorReducer';

export default (props, railsContext) => {

  const finalCreateStore = compose(
    applyMiddleware(thunkMiddleware),
  )(createStore);

  return finalCreateStore(visitorReducer);
}
