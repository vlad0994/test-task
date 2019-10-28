module ErrorsHelper
  def generate_errors(model, errors)
    model_instance = model.new

    errors.each do |key, val|
      model_instance.errors.add(key, val)
    end

    model_instance.errors
  end
end