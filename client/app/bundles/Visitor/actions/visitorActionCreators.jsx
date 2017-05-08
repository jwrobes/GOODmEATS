/* eslint-disable import/prefer-default-export */
import request from 'axios';
import { HELLO_WORLD_NAME_UPDATE } from '../constants/visitorConstants';
import { UPDATE_RESTAURANTS } from '../constants/visitorConstants';
import { RESTAURANTS_ADDED } from '../constants/visitorConstants';
import { ONE_MORE_SEARCH } from '../constants/visitorConstants';

const restaurantsLoaded = (payload) => {
  return {
    payload,
    type: UPDATE_RESTAURANTS,
  }
}

const restaurantsAdded = (payload) => {
  return {
    payload,
    type: RESTAURANTS_ADDED,
  }
}

function doSearch(entity) {
  return request({
    method: 'POST',
    url: '/restaurant_searches',
    responseType: 'json',
    headers: ReactOnRails.authenticityHeaders(),
    data: entity,
  });
}

export function searchMoreRestaurants(search) {
  return (dispatch, getState) => {
    const searchData = search;
    searchData.offset = getState().searchCount;
    return doSearch(searchData)
      .then(function(res){
        dispatch(restaurantsAdded(res.data));
        if (search.offset < 5) {
          dispatch(searchMoreRestaurants(search));
          dispatch({type: ONE_MORE_SEARCH})
        }
      })
      .catch(function(error){
        debugger;
      });
  }
}
export function searchRestaurants(search) {
  const searchData = search;
  return (dispatch, getState) => {
    const searchCount = getState().searchCount;
    return doSearch(searchData)
      .then((res) => {
        dispatch(restaurantsLoaded(res.data));
        if (searchCount < 5 ) {
          dispatch(searchMoreRestaurants(search));
          dispatch({type: ONE_MORE_SEARCH});
        }
      })
      .catch(function(error){
        debugger;
      });
  }
}
