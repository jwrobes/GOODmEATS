import React from 'react'
import PropTypes from 'prop-types';

const RestaurantsList = (props) => {

  const { restaurants } = props;
  const renderRestaurants = () => {
    return restaurants.map((restaurant) => {
      const { api_id, name, diplay_address, phone } = restaurant;
      return (
        <div key={api_id}>
          <div>{name}</div>
          <div>{phone}</div>
          <br/>
        </div>
      );
    });
  };
  return (
    <div>
      {renderRestaurants()}
    </div>
  );
}

RestaurantsList.propTypes = {
  restaurants: PropTypes.array.isRequired,
};

export default RestaurantsList;
