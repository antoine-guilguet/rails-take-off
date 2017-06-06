console.log('yes')
var surveyDateId = <%= params[:survey_date_id] %>
console.log(surveyDateId)
var votes = <%= SurveyDate.find(params[:survey_date_id]).votes_for.size %>
console.log(votes)
var selector = '#survey_date_' + surveyDateId
console.log(typeof(selector))
$(selector).text(votes);


