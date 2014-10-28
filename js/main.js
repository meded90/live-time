// Generated by CoffeeScript 1.7.1
(function() {
  var LiveTime;

  LiveTime = (function() {
    function LiveTime(optiuns) {
      this.$datePiker = $(optiuns.datePiker);
      this.$tableLive = $(optiuns.tableLive);
      this.$dataYear = $(optiuns.year);
      this.dataBirthday = optiuns.dataBirthday || '';
      this.dataBirthday = optiuns.dataYear || 90;
      this.initDatePiker();
      this.initDateYear();
      this.getStorage();
      this.renderTable();
    }

    LiveTime.prototype.renderTable = function() {
      var count, i, j, table, _i, _j, _ref;
      if (!this.dataYear || !this.dataBirthday) {
        return;
      }
      table = '<table class="table table-bordered">';
      count = this.getCountWeek(this.dataBirthday);
      for (i = _i = 0, _ref = this.dataYear; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        table += '<tr>';
        for (j = _j = 0; _j < 53; j = ++_j) {
          if (j === 0) {
            table += "<td class='year'>" + i + "</td>";
          } else {
            if (count >= 0) {
              table += '<td class="select"></td>';
              count = count - 1;
            } else {
              table += '<td></td>';
            }
          }
        }
        table += '<tr>';
      }
      table += '</table>';
      return this.$tableLive.html(table);
    };

    LiveTime.prototype.initDatePiker = function() {
      this.$datePiker.datepicker({
        startView: 2,
        endDate: new Date(),
        todayHighlight: true
      });
      this.$datePiker.on('changeDate', (function(_this) {
        return function() {
          _this.dataBirthday = _this.$datePiker.datepicker('getDate');
          _this.setStorage();
          return _this.renderTable();
        };
      })(this));
      return this.$dataYear.on('change', (function(_this) {
        return function() {
          _this.dataBirthday = _this.$datePiker.datepicker('getDate');
          _this.setStorage();
          return _this.renderTable();
        };
      })(this));
    };

    LiveTime.prototype.initDateYear = function() {
      return this.$dataYear.on('change', (function(_this) {
        return function() {
          _this.dataYear = _this.$dataYear.val();
          _this.setStorage();
          return _this.renderTable();
        };
      })(this));
    };

    LiveTime.prototype.getStorage = function() {
      var dataYear, time;
      time = +localStorage.getItem('timelive');
      dataYear = +localStorage.getItem('timeYear');
      if (dataYear) {
        this.dataYear = dataYear;
        this.$dataYear.val(this.dataYear);
        this.$datePiker.parents('.form-group').removeClass('has-error');
      } else {
        this.$datePiker.parents('.form-group').addClass('has-error');
      }
      if (time) {
        this.dataBirthday = new Date(time);
        this.$datePiker.datepicker('update', this.dataBirthday);
        return this.$datePiker.parents('.form-group').removeClass('has-error');
      } else {
        return this.$datePiker.parents('.form-group').addClass('has-error');
      }
    };

    LiveTime.prototype.setStorage = function() {
      localStorage.setItem('timelive', this.dataBirthday.getTime());
      return localStorage.setItem('timeYear', this.dataYear);
    };

    LiveTime.prototype.getCountWeek = function(date) {
      var offset;
      offset = moment(date).twix(new Date()).count('year') * 0.1774568456;
      return moment(date).twix(new Date()).count('week') - offset;
    };

    return LiveTime;

  })();

  new LiveTime({
    datePiker: '#date',
    tableLive: '#table',
    year: '#year'
  });

}).call(this);

//# sourceMappingURL=main.map
