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
        image_url: 'https://www.scienceabc.com/wp-content/uploads/2016/05/horse-running.jpg',
        subtitle: horse.description,
        buttons: [
          {
            type: 'postback',
            title: 'Show me this cute horse!',
            payload: "horse_1"
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
  when /horse/i
    message.reply(
      text: 'You want to see the horses?',
      quick_replies: [
        {
          content_type: 'text',
          title: 'Yes indeed!',
          payload: 'HORSES'
        },
        {
          content_type: 'location',
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
    message.reply(
      text: 'You are now marked for extermination.'
    )

    message.reply(
      text: 'Have a nice day.'
    )
  end
end

Bot.on :postback do |postback|
  case postback.payload
  when 'HUMAN_LIKED'
    text = 'That makes bot happy!'
  when 'HUMAN_DISLIKED'
    text = 'Oh.'
  when "horse_1"
    horse = Horse.find(1)
    text = "Daily price: #{horse.price} €"
  end

  postback.reply(
    text: text
  )
end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
