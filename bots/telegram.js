process.env["NTBA_FIX_319"] = 1; // fix for the deprecation of the promises cancellation error

const TelegramBot = require('node-telegram-bot-api'),
bot = new TelegramBot(botconfig.token, { polling: true });

console.log("Starting bot...");

bot.on('polling_error', (error) => {
  console.log(error);  // => 'EFATAL'
});

bot.on('message', (message) => {
//    console.log(JSON.stringify(message, null, 4)); //output entire message object. Comment out.
//console.log(Object.keys(message));
//console.log(message.chat.id);
    if(message.chat.id != "-1001120853347") { // make sure it's from dojo Telegram
        return;
    }

var messageKeys = Object.keys(message); // get all of the keys in the message object
//console.log(messageKeys);

    var spamIndex = 0;
    var checkIndex = 0;
    var detectedWords = "";
    var checkText = "";
    var reason = "kicked for spamming";

    if(messageKeys.indexOf("text") > -1) {
            checkText = message.text.toString().toLowerCase()
            checkText = checkText.replace('+',' ');
            checkText = checkText.replace('_',' ');
            checkText = checkText.replace('#',' ');
            checkText = checkText.replace('!',' ');
            checkText = checkText.replace('?',' ');
    } else if(messageKeys.indexOf("photo") > -1) {
        detectedWords = detectedWords + " [photo]";
        spamIndex = spamIndex + 1;
    }
    if(messageKeys.indexOf("caption") > -1) {
            checkText = message.caption.toString().toLowerCase()
            checkText = checkText.replace('+',' ');
            checkText = checkText.replace('_',' ');
            checkText = checkText.replace('#',' ');
            checkText = checkText.replace('!',' ');
            checkText = checkText.replace('?',' ');
    }
    if(messageKeys.indexOf("new_chat_participant") > -1) {
            console.log("New user: " + message.from.first_name);
    } else {
            console.log("Type not defined");
    }

// CHECK FOR VIRUSES - EXECUTABLES ARE INSTABAN //
    if(messageKeys.indexOf("document") > -1) {
        var extensions=['.exe', '.bat', '.scr', '.pif', '.bat', '.apk', '.inf', '.app', '.bin', '.cmd', '.vb', '.ws', '.msi', '.doc', '.pdf', '.xls', '.docx', '.xlsx']
        extensions.forEach(function(extension) {
            if(message.document.file_name.indexOf(extension) > -1) {
                  spamIndex = spamIndex +6;
                  console.log(message.document.file_name);
                  detectedWords = detectedWords + " [VIRUS]";
                  reason =  " Retard posted a virus";
            }
        });
    }

// Read JSON Rules file and check message against it
    var ruleset = require('./rules.json');
    var rules = Object.keys(ruleset);
    rules.forEach(function(item) {
        if(checkText.indexOf(ruleset[item].name) > -1) {
              spamIndex = spamIndex + ruleset[item].weight;
              detectedWords = detectedWords + ruleset[item].name + " ";
        }
    });


// APPLY CONSEQUENCES BASED ON SPAM LEVEL //
    if(spamIndex > 2) {
        try {
          console.log('\x1b[91mUser: @' + message.from.username + ' ( ' + message.from.first_name + ' ) ' + ' kicked for spamming\x1b[0m');
          //bot.sendMessage(message.chat.id, 'User: @' + message.from.username + ' ( ' + message.from.first_name + ' ) ' + reason + ' | Spam Index: ' + spamIndex);
        }
        catch(error) {
          console.error(error);
        }

        try {
                bot.deleteMessage(message.chat.id, message.message_id);
        }
        catch(error) {
          console.error(error);
        }

        try {
                bot.kickChatMember(message.chat.id, message.from.id);
        }
        catch(error) {
          console.error(error);
        }
     }
     console.log("==========================================================");
     console.log('\x1b[92m' + checkText + '\x1b[0m');
     console.log('\x1b[93mUser: \x1b[0m@' + message.from.username + ' ( ' + message.from.first_name + ' ) ' );
     console.log('\x1b[93mDetected Words: \x1b[91m' + detectedWords + '\x1b[0m');
     console.log('Spam Index: ' + spamIndex);
     console.log("==========================================================\n");
});
