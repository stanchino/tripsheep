module TripHelper
  def fields_for_new_destination(form_builder, position = nil)
    child_index = position || 'new_destination'
    position ||= Time.now.to_i
    new_object = form_builder.object.class.reflect_on_association(:destinations).klass.new(:position => position)
    form_builder.simple_fields_for :destinations, new_object, child_index: child_index do |builder|
      render 'destinations/form', builder: builder
    end
  end
  
  def destination_placeholder(destination)
    placeholder = 'From:' if destination.first?
    placeholder ||= 'To:' if destination.last?
    placeholder ||= "Waypoint"
  end
end