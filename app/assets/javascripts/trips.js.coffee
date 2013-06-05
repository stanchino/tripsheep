$ ->
  window.Tripsheep or= {}
  window.Tripsheep.ViewHelpers or= {}

  class Tripsheep.ViewHelpers.TripsHelper
    constructor: ->
      @selectors = 
        new_destination_link: '.add-destination'
        destinations_placeholder: '#destinations'
        new_destination_template: '#new_destination_template'
        autocomplete: '.autocomplete'
        remove_destination: '.remove-destination:not(.disabled)'
        destination_placeholder: '.destination-placeholder'
        datepicker: '.date'

    init: ->
      @$destinations_placeholder = $(@selectors.destinations_placeholder)
      @$new_destination_content =  $(@selectors.new_destination_template).html()
      @bind_events()

    bind_events: ->
      @bind_address_autocomplete()
      @bind_add_destination()
      @bind_remove_destination()
      @bind_datetimepicker()

    bind_datetimepicker: ->
      $(@selectors.datepicker).
      datetimepicker().
      off('changeDate').
      on 'changeDate', (event) =>
        $(event.target).
        datetimepicker('hide').
        next('input[type="text"]').
        val($.datepicker.formatDate('M dd', event.date))

    bind_add_destination: ->
      $(@selectors.new_destination_link).
      off('ajax:success').
      on 'ajax:success', (xhr, data, status) =>
        $(xhr.target).closest(@selectors.destination_placeholder).
        after $(data).fadeIn 400, ()=>
          @bind_events()

    bind_remove_destination: ->
      $(@selectors.remove_destination).
      off('ajax:success').
      on 'ajax:success', (xhr, data, status) =>
        $(xhr.target).closest(@selectors.destination_placeholder).
          fadeOut 400, () ->
            this.remove()
    
    bind_address_autocomplete: ->
      $(@selectors.autocomplete).autocomplete
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

    new_destination_template: =>
      @$new_destination_content

    update_data: (position, delta) =>
      $(@selectors.destination_placeholder)[position..].each (id, el) =>
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
