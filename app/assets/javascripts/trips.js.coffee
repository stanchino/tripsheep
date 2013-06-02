$ ->
  window.Tripsheep or= {}
  window.Tripsheep.ViewHelpers or= {}

  class Tripsheep.ViewHelpers.TripsHelper
    constructor: ->
      @selectors = 
        new_waypoint_link: '[data-trigger=new-waypoint]'
        waypoints_placeholder: '#waypoints'
        new_waypoint_template: '#new_waypoint_template'

    init: ->
      @$waypoints_placeholder = $(@selectors.waypoints_placeholder)
      @$new_waypoint_content =  $(@selectors.new_waypoint_template).html()
      
      @bind_address_autocomplete()
      @bind_add_waypoint()
      
    bind_add_waypoint: ->
      $(@selectors.new_waypoint_link).on 'click', (event) =>
        @$waypoints_placeholder.append @new_waypoint_template()
    
    bind_address_autocomplete: ->
      $( ".autocomplete" ).autocomplete
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
                { label: item.name + ", " + item.countryName, value: item.name}
                
        minLength: 2
        select: (event, ui) ->
          console.log ui.item
            #ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
        open: ->
          $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        close: ->
          $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );

    new_waypoint_template: =>
      new_content = @$new_waypoint_content
      new_id = new Date().getTime()
      regexp = new RegExp("new_waypoint", "g")
      new_content.replace(regexp, new_id)

  trips_helper = new Tripsheep.ViewHelpers.TripsHelper
  trips_helper.init()
