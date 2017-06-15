function activateDatePicker(){
    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 15, // Creates a dropdown of 15 years to control year
        firstDay: 1, // Weeks starts on Monday
        closeOnClear: true,
        onSet: function( arg ){
            if ( 'select' in arg ){ //prevent closing on selecting month/year
                this.close();
            }
        }
    });
};

function nextWeekEndDate(date) {
    if (date.getDay() == 6){
        return date;
    } else {
        diff = Math.abs( 6 - date.getDay() );
        return new Date(Date.parse(date) + diff*24*60*60*1000);
    };
}

function addDaysToDate(date, days){
    return new Date(Date.parse(date.toString()) + days*24*60*60*1000);
};

