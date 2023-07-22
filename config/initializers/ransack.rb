Ransack.configure do |config|
  config.add_predicate 'custom_eq', # Name your custom predicate
    arel_predicate: 'eq', # Use the Arel `eq` predicate (change as needed)
    formatter: proc { |v| v }, # Customize the value as needed
    validator: proc { |v| v.present? }, # Set the condition for filtering (change as needed)
    compounds: true, # Define if it can be used for compound conditions (optional)
    type: :string # Set the data type of the custom predicate (change as needed)
end