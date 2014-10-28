class LiveTime
  constructor:(optiuns)->
    @$datePiker = $(optiuns.datePiker)
    @$tableLive = $(optiuns.tableLive)
    @dataBirthday = optiuns.dataBirthday || ''

    do @initDatePiker
    do @getStorage

  renderTable:->
    console.log '-------------'
    table = '<table class="table table-bordered">'
    count = @getCountWeek(@dataBirthday)
    for i in [0...60]
      table += '<tr>'
      for j in [0...53]
        if j == 0
          table += "<td class='year'>#{i}</td>"
        else
          if count >=0
            table += '<td class="select"></td>'
            count = count- 1
          else
            table += '<td></td>'
      table += '<tr>'
    table += '</table>'
    @$tableLive.html table


  initDatePiker:->
    @$datePiker.datepicker({
      startView: 2,
      endDate: new Date()
      todayHighlight: true
    })
    @$datePiker.on('changeDate', =>
        @dataBirthday = @$datePiker.datepicker('getDate')
        @setStorage()
        @renderTable()
    )
  getStorage:->
    time  = +localStorage.getItem('timelive')
    if time
      @dataBirthday = new Date(time)
      @$datePiker.datepicker('update', @dataBirthday)
      @renderTable()
  setStorage:->
    localStorage.setItem('timelive',@dataBirthday.getTime())

  getCountWeek:(date)->
    offset = moment(date).twix(new Date()).count('year') * 0.1774568456
    moment(date).twix(new Date()).count('week') - offset


new LiveTime(
  datePiker: '#date'
  tableLive: '#table'
)