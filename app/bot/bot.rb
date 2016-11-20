require 'facebook/messenger'

include Facebook::Messenger
# include ApplicationHelper

# Facebook::Messenger::Thread.set(
#   setting_type: 'call_to_actions',
#   thread_state: 'existing_thread',
#   call_to_actions: [
#     {
#       type: 'postback',
#       title: 'Help',
#       payload: 'HUMAN_LIKED'
#     },
#     {
#       type: 'postback',
#       title: 'Start a New Order',
#       payload: 'horse_1'
#     },
#     {
#       type: 'web_url',
#       title: 'View Website',
#       url: 'http://ride-my-horse.herokuapp.com/'
#     }
#   ]
# )

Bot.on :message do |message|
  puts "Received '#{message.inspect}' from #{message.sender}"

  case message.text
  when /horses/i
    @horses = Horse.all
    elements = @horses.map do |horse|
      {
        title: horse.name,
        image_url: 'https://www.scienceabc.com/wp-content/uploads/2016/05/horse-running.jpg', # helpers.image_path('logo.jpg'),
        subtitle: horse.description,
        buttons: [
          {
            type: 'postback',
            title: 'Pricey horse?',
            payload: "HORSE_#{horse.id}"
          }
        ]
      }
    end
    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          elements: elements.sample(5)
        }
      }
    )
  when /near/i
    message.reply(
      text: 'Where are you?',
      quick_replies: [
        {
          content_type: 'location'
        }
      ]
    )
  when /hello/i
    message.reply(
      text: 'Hello, human!',
      quick_replies: [
        {
          content_type: 'text',
          title: 'Hello, bot!',
          payload: 'HELLO_BOT'
        }
      ]
    )
  when /something humans like/i
    message.reply(
      text: 'I found something humans seem to like:'
    )

    message.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://i.imgur.com/iMKrDQc.gif'
        }
      }
    )

    message.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'Did human like it?',
          buttons: [
            { type: 'postback', title: 'Yes', payload: 'HUMAN_LIKED' },
            { type: 'postback', title: 'No', payload: 'HUMAN_DISLIKED' }
          ]
        }
      }
    )
  else
    if message.attachments.try(:[], 0).try(:[], 'payload').try(:[], 'coordinates')
      lat = message.attachments[0]['payload']['coordinates']['lat']
      lng = message.attachments[0]['payload']['coordinates']['long']
      message.reply(
        text: "Your coordinates: #{lat}, #{lng}"
      )
    elsif message.text
      message.reply(
        text: "Did you say '#{message.text}'?"
      )
    else
      message.reply(
        text: "Did not understand"
      )
    end
  end
end

Bot.on :postback do |postback|
  case postback.payload
  when 'HUMAN_LIKED'
    text = 'That makes bot happy!'
  when 'HUMAN_DISLIKED'
    text = 'Oh.'
  when /HORSE_(?<id>\d+)/
    horse = Horse.find($LAST_MATCH_INFO['id'])
    text = "#{horse.name} daily price: #{horse.price} €"
  when /coordinates/
    lat = postback.payload.coordinates.lat
    lng = postback.payload.coordinates.long
    text = "Your coordinates: #{lat}, #{lng}"
  end

  postback.reply(
    text: text
  )
end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
