

var topicCard = $("<%= j render 'topics/topic_card', topic: @topic %>").hide();

$('.trip-topics').prepend(topicCard);

topicCard.slideDown();

