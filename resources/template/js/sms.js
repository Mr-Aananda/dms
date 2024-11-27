const message = document.getElementById("message");
const totalCharacters = document.getElementById("total_characters");
let totalMessage = document.getElementById("total_messages");
const templateInput = document.getElementById("template");

// For character count
message.addEventListener("input", function () {
    const count = message.value.length + 25;
    totalCharacters.value = count;

    let english = /^[~!@#$%^&*(){},.:/-_=+A-Za-z0-9 ]*$/;
    let messageLength;

    if (english.test(message.value)) {
        if (count <= 160) {
            messageLength = 1;
        } else {
            messageLength = Math.ceil(count / 153); // For GSM-7 encoding
        }
    } else {
        if (count <= 63) {
            messageLength = 1;
        } else {
            messageLength = Math.ceil(count / 67); // For UCS-2 encoding
        }
    }

    totalMessage.value = messageLength;
});

// For template sms
function fillMessageFromTemplate(e) {
    let template = e.target.value;
    message.value = template;
    let templateCount = template.length + 25;

    let english = /^[~!@#$%^&*(){},.:/-_=+A-Za-z0-9 ]*$/;
    let messageLength;

    if (english.test(template)) {
        if (templateCount <= 160) {
            messageLength = 1;
        } else {
            messageLength = Math.ceil(templateCount / 153); // For GSM-7 encoding
        }
    } else {
        if (templateCount <= 63) {
            messageLength = 1;
        } else {
            messageLength = Math.ceil(templateCount / 67); // For UCS-2 encoding
        }
    }

    totalCharacters.value = templateCount;
    totalMessage.value = messageLength;
}

// Event listener for template input field
templateInput.addEventListener("input", fillMessageFromTemplate);
