require('pry-byebug')
require_relative('models/property_tracker')

  property1 = PropertyTracker.new({
    'address' => 'Big House, Mayfair',
    'value' => '10',
    'number_of_bedrooms' => '10',
    'buy_let_status' => 'false'
    })


    property2 = PropertyTracker.new({
      'address' => 'White House, Washington DC',
      'value' => '100',
      'number_of_bedrooms' => '20',
      'buy_let_status' => 'true'
    })

    property1.save()
    binding.pry
    nil
