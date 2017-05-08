import PropTypes from 'prop-types';
import React from 'react';

import RestaurantSearch from '../components/RestaurantSeach';
import RestaurantsList from '../components/RestaurantsList';

const Visitor = ({ searchRestaurants, restaurants }) => (
  <div>
    <RestaurantSearch onSubmit={searchRestaurants} />
    <RestaurantsList restaurants={restaurants} />
  </div>
);

Visitor.propTypes = {
  searchRestaurants: PropTypes.func.isRequired,
  restaurants: PropTypes.array.isRequired,
};

export default Visitor;
