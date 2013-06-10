$ ->
  window.Tripsheep or= {}
  window.Tripsheep.ViewHelpers or= {}

  class Tripsheep.ViewHelpers.TripsHelper
    constructor: ->
      @selectors =
        placeholder: '.destination' 
        add_destination: '.add-destination'
        remove_destination: '.remove-destination'
        template: '#new-destination-template'
        autocomplete: '.autocomplete'
        datepicker: '.datepicker'

    init: ->
      @$new_destination_content =  $(@selectors.template).html()
      @bind_events $(@selectors.placeholder)

    bind_events: (context) ->
      @bind_address_autocomplete(context)
      @bind_add_destination(context)
      @bind_remove_destination(context)
      @bind_datepicker(context)
      #$('.days', context).combobox()

    bind_datepicker: (context) ->
      $(@selectors.datepicker).datepicker()
     

    bind_add_destination: (context) ->
      $(@selectors.add_destination, context).
      on 'click', (event) =>
        $placeholder = $(event.target).closest(@selectors.placeholder)
        current_position = parseInt $placeholder.data('position')
        next_position = parseInt $placeholder.next().data('position')
        position = parseInt (current_position + next_position) / 2
        console.log "Current: #{current_position}, Next: #{next_position}, Position: #{position}"
        $template = $(@new_destination_template(position)).data('position', position)
        $placeholder.after $template.fadeIn 400, ()=>
          @bind_events $template
        false

    bind_remove_destination: (context) ->
      $(@selectors.remove_destination, context).
      on 'click', (event) =>
        $(event.target).closest(@selectors.placeholder).
          fadeOut 400, () ->
            this.remove()
        false
    
    bind_address_autocomplete: (context) ->
      $(@selectors.autocomplete, context).autocomplete
        source: (request, response) ->
          $.ajax
            url: "http://ws.geonames.org/searchJSON",
            dataType: "jsonp",
            data: 
              featureClass: "P",
              style: "full",
              maxRows: 12,
              name_startsWith: request.term
            success: (data) ->
              response $.map data.geonames, (item) ->
                {
                label: item.name + ", " + item.countryName,
                value: item.name + ", " + item.countryName
                }
        select: (event, ui) ->
          #console.log ui.item
          #ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
        open: ->
          $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        close: ->
          $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );

    new_destination_template: (position) =>
      new_id = new Date().getTime()
      new_id = parseInt(position) + 1 unless typeof position == 'undefined'
      regexp = new RegExp "new_destination", "g"
      @$new_destination_content.replace regexp, new_id

    update_data: (position, delta) =>
      $(@selectors.placeholder)[position..].each (id, el) =>
        $el = $(el)
        $destination_link = $(@selectors.new_destination_link, $el)
        $destination_input = $(@selectors.autocomplete, $el)
        pos = parseInt $destination_link.data('position')
        name = $destination_input.attr('name')
        id = $destination_input.attr('id')
        new_position = pos + delta
        $destination_link.data('position', new_position)
        $destination_input.
        attr('name', name.replace("[#{pos}]", "[#{new_position}]")).
        attr('id', id.replace("_#{pos}_", "_#{new_position}_"))

  trips_helper = new Tripsheep.ViewHelpers.TripsHelper
  trips_helper.init()
