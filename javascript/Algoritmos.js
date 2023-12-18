function greatestNumber(array) {
    for (let i of array) {
        let isIValTheGreatest = true;
        for (let j of array) {
            if (j > i) {
                isIValTheGreatest = false;
            }
        }
        if (isIValTheGreatest) {
            return i;
        }
    }
}

function greatestNumber(array) {
    let greatest = array[0];
    for (let i of array) {
        if (i > greatest) {
            greatest = i;
        }
    }
    return greatest;
}

function containsX(string) {
    foundX = false;
    for(let i = 0; i < string.length; i++) {
        if (string[i] === "X") {
            foundX = true;
        }
    }
    return foundX;
}


function containsX(string) {
    for(let i = 0; i < string.length; i++) {
        if (string[i] === "X") {
            return true;
        }
    }
    return false;
}

function firstCharacterDontRepeat(string) {
    for(let i = 0; i < string.length; i++) {
        let isRepeated = false;
        for(let j = 0; j < string.length; j++) {
            if (i !== j && string[i] === string[j]) {
                isRepeated = true;
            }
        }
        if (!isRepeated) {
            return string[i];
        }
    }
}
