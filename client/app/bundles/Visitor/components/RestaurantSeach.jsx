import React from 'react'
import PropTypes from 'prop-types';
import { Form, Input } from 'formsy-react-components';

const { func } = PropTypes;

const RestaurantSearch = (props) => {

  const renderSubmit = () => {
    return (
      <button>
        Submit
      </button>
    );
  };

  const renderForm = () => {
    return (
      <Form onSubmit={props.onSubmit}>
        <Input
          name="query"
          label="query"
          type="text"
        />
        <Input
          name="location"
          label="location"
          type="text"
        />
        {renderSubmit()}
      </Form>
    );
  };

  return (
    <div>
      {renderForm()}
    </div>
  );
}

RestaurantSearch.propTypes = {
  onSubmit: func.isRequired,
};

export default RestaurantSearch;
