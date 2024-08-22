window.onload = function () {
    table = document.getElementById('tableResult');
    inputArray = document.getElementsByName('input');
}

const doAdd = function () {
    if (doAlert()) {
        return;
    }
    let trObj = createEle('tr');
    createObj('radio', trObj);
    createObj('span', trObj);
    for (let input of inputArray) {
        let tdObj = createEle('td');
        let spanObj = createEle('span');
        spanObj.innerHTML = input.value;
        appendChilds(spanObj, tdObj, trObj, table);
    }
    createObj('button', trObj);
}

const doAlter = function () {
    let next;
    const radioArray = document.getElementsByName('radio');
    for (let radio of radioArray) {
        if (radio.checked) {
            next = radio;
        }
    }
    if (!radioArray[0]) {
        alert('提醒：目前無資料可供修改！');
        return;
    } else if (!next) {
        alert('提醒：請點選任一資料進行修改！');
        return;
    } else if (doAlert()) {
        return;
    }
    next = next.parentNode.nextElementSibling.firstElementChild;
    for (let input of inputArray) {
        next = next.parentNode.nextElementSibling.firstElementChild;
        next.innerHTML = input.value;
    }
}

const doClear = function () {
    let i = table.rows.length;
    while (i > 1) {
        table.deleteRow(--i);
    }
    for (let input of inputArray) {
        input.value = '';
    }
}

const doDelete = function (thisObj) {
    thisObj.parentNode.parentNode.remove();
    const numberArray = document.getElementsByName('number');
    for (let i = 0; i < numberArray.length; i++) {
        numberArray[i].innerHTML = i + 1;
    }
}

const doBringIn = function (thisObj) {
    let next = thisObj.parentNode.nextElementSibling.firstElementChild;
    for (let input of inputArray) {
        next = next.parentNode.nextElementSibling.firstElementChild;
        input.value = next.innerHTML;
    }
}

const createEle = function (ele) {
    return document.createElement(ele);
}

const createObj = function (str, trObj) {
    let obj;
    let tdObj = createEle('td');
    if (str === 'span') {
        obj = createEle(str);
        obj.setAttribute('name', 'number');
        obj.innerHTML = table.rows.length - 1;
    } else if (str === 'radio') {
        obj = createEle('input');
        obj.setAttribute('type', str);
        obj.setAttribute('name', 'radio');
        obj.setAttribute('onclick', 'doBringIn(this)');
    } else if (str === 'button') {
        obj = createEle(str);
        obj.setAttribute('type', str);
        obj.setAttribute('onclick', 'doDelete(this)');
        obj.innerHTML = '刪除';
    }
    appendChilds(obj, tdObj, trObj, table);
}

const appendChilds = function (child1, child2, child3, child4) {
    child2.appendChild(child1);
    child3.appendChild(child2);
    child4.appendChild(child3);
}

const doAlert = function () {
    const boolean = true;
    if (!inputArray[0].value.trim() || !inputArray[1].value.trim()) {
        alert('提醒：製造商及類別不可為空！');
        return boolean;
    } else if (isNaN(inputArray[2].value) || isNaN(inputArray[3].value)) {
        alert('提醒：底價及售價須為數字！');
        return boolean;
    } else if (inputArray[2].value < 0 || inputArray[3].value < 0) {
        alert('提醒：底價及售價不可為負值！');
        return boolean;
    }
}

