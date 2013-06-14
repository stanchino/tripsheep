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
        datepicker: '.datepicker-trigger'
        start_date: '#trip_start_date'
        end_date: '#trip_end_date'

    init: ->
      @$new_destination_content =  $(@selectors.template).html()
      @bind_events $(@selectors.placeholder)
      @bind_datepicker()

    bind_events: (context) ->
      @bind_address_autocomplete(context)
      @bind_add_destination(context)
      @bind_remove_destination(context)
      @bind_days_validation(context)

    bind_datepicker: ->
      $start_date = $(@selectors.start_date)
      $end_date = $(@selectors.end_date)
      start_date = $start_date.val()
      end_date = $end_date.val()
      $start_date.datepicker({
        minDate: 0,
        dateFormat: 'M dd, yy',
        showOn: 'focus',
        onClose: (selectedDate, item) =>
          $start_date.trigger 'blur'
          $end_date.datepicker('option', 'minDate', selectedDate)
      })
      $end_date.datepicker({
        minDate: 0,
        dateFormat: 'M dd, yy',
        showOn: 'focus',
        onClose: (selectedDate, item) =>
          $(item.input).data('selected', true)
          $start_date.datepicker('option', 'maxDate', selectedDate)
      })
      $(@selectors.datepicker).each (i, trigger) =>
        $trigger = $(trigger)
        $trigger.on 'click', (event) ->
          $trigger.next('input').datepicker('show')

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
          $(event.target).val(ui.item.value).trigger 'change'
        open: ->
          $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        close: ->
          $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );

    bind_days_validation: (context) ->
      $days = $('.days', context)
      $hours = $('.hours', context)
      $days.on 'change', (event) =>
        if event.target.value == '0'
          $hours.removeAttr('val')
          $hours.closest('.control-group').removeClass('invisible')
        else
          $hours.val(1)
          $hours.closest('.control-group').addClass('invisible')
        @update_end_date()

    new_destination_template: (position) =>
      new_id = new Date().getTime()
      new_id = parseInt(position) + 1 unless typeof position == 'undefined'
      regexp = new RegExp "new_destination", "g"
      @$new_destination_content.replace regexp, new_id

    update_end_date: ->
      $start_date = $(@selectors.start_date)
      $end_date = $(@selectors.end_date)
      start_date = $start_date.val()
      end_date = $end_date.val()
      if !start_date
        return

      days = Math.floor((Date.parse(end_date) - Date.parse(start_date)) / 86400000)
      if isNaN days
        days = 0

      total = 0
      $('.days').each (i, el) ->
        total += parseInt(el.value)

      if $end_date.data?('selected') && total > days && days > 0
        $end_date.tooltip({placement: 'right', title: 'The end date was changed', trigger: 'manual'})
        $end_date.tooltip('show')
        $end_date.data('selected', false)
      else if $end_date.data?('tooltip')
        $end_date.tooltip('destroy')
      if !$end_date.data?('selected')
        date = $end_date.datepicker('getDate') || $start_date.datepicker('getDate')
        date.setDate(date.getDate() + total - days)
        $end_date.datepicker('setDate', date)

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
