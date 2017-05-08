import { combineReducers } from 'redux';
import Immutable from 'seamless-immutable';

import { HELLO_WORLD_NAME_UPDATE } from '../constants/visitorConstants';
import { UPDATE_RESTAURANTS } from '../constants/visitorConstants';
import { RESTAURANTS_ADDED } from '../constants/visitorConstants';
import { ONE_MORE_SEARCH } from '../constants/visitorConstants';

export const defaultState = Immutable({
  restaurants: [],
  searchCount: 1,
});

export default function visitorReducer(state = defaultState, action) {
  const { type, payload } = action;
  switch (type) {
    case UPDATE_RESTAURANTS:
      return state.set('restaurants', payload);
      return state.set('restaurants', payload);
    case ONE_MORE_SEARCH:
      const newSearchCount = state.searchCount + 1;
      return state.set('searchCount', newSearchCount);
    case RESTAURANTS_ADDED:
      const newRestaurants = state.restaurants.concat(payload);
      return state.set('restaurants', newRestaurants);
    default:
      return state;
  }
}

