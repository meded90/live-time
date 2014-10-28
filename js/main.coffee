class LiveTime
  constructor: ( optiuns )->
    @$datePiker = $( optiuns.datePiker )
    @$tableLive = $( optiuns.tableLive )
    @$dataYear = $( optiuns.year )
    @dataBirthday = optiuns.dataBirthday || ''
    @dataBirthday = optiuns.dataYear || 90

    do @initDatePiker
    do @initDateYear
    do @getStorage
    @renderTable()


  renderTable: ->
    if  !@dataYear or !@dataBirthday then return
    table = '<table class="table table-bordered">'
    count = @getCountWeek( @dataBirthday )
    for i in [0...@dataYear]
      table += '<tr>'
      for j in [0...53]
        if j == 0
          table += "<td class='year'>#{i}</td>"
        else
          if count >= 0
            table += '<td class="select"></td>'
            count = count - 1
          else
            table += '<td></td>'
      table += '<tr>'
    table += '</table>'
    @$tableLive.html table


  initDatePiker: ->
    @$datePiker.datepicker( {
      startView: 2,
      endDate: new Date()
      todayHighlight: true
    } )
    @$datePiker.on( 'changeDate', =>
      @dataBirthday = @$datePiker.datepicker( 'getDate' )
      do  @setStorage
      do  @renderTable
      if @$datePiker
        @$datePiker.parents('.form-group').removeClass('has-error')
      else
        @$datePiker.parents('.form-group').addClass('has-error')
    )
    @$dataYear.on 'change', =>
      @dataBirthday = @$datePiker.datepicker( 'getDate' )
      do  @setStorage
      do  @renderTable
      if @$datePiker
        @$datePiker.parents('.form-group').removeClass('has-error')
      else
        @$datePiker.parents('.form-group').addClass('has-error')

  initDateYear: ->
    @$dataYear.on 'change', =>
      @dataYear = @$dataYear.val()
      do @setStorage
      do @renderTable
      if @$dataYear
        @$dataYear.parents('.form-group').removeClass('has-error')
      else
        @$dataYear.parents('.form-group').addClass('has-error')

  getStorage: ->
    time = +localStorage.getItem( 'timelive' )
    dataYear = +localStorage.getItem( 'timeYear' )
    if dataYear
      @dataYear = dataYear
      @$dataYear.val( @dataYear )
      @$datePiker.parents('.form-group').removeClass('has-error')
    else
      @$datePiker.parents('.form-group').addClass('has-error')

    if time
      @dataBirthday = new Date( time )
      @$datePiker.datepicker( 'update', @dataBirthday )
      @$datePiker.parents('.form-group').removeClass('has-error')
    else
      @$datePiker.parents('.form-group').addClass('has-error')

  setStorage: ->
    localStorage.setItem( 'timelive', @dataBirthday.getTime() )
    @dataYear  = @$dataYear.val()
    localStorage.setItem( 'timeYear', @dataYear )

  getCountWeek: ( date )->
    offset = moment( date ).twix( new Date() ).count( 'year' ) * 0.1774568456
    moment( date ).twix( new Date() ).count( 'week' ) - offset


new LiveTime(
  datePiker: '#date'
  tableLive: '#table'
  year: '#year'
)