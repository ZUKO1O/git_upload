window.onload = function () {
    table = document.getElementById('tableResult');
    inputArray = document.getElementsByName('input');
}

const doAdd = function () {
    if (!inputArray[0].value.trim() || !inputArray[1].value.trim()) {
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
    if (!inputArray[0].value.trim() || !inputArray[1].value.trim()) {
        return;
    }
    let next;
    const radioArray = document.getElementsByName('radio');
    for (let radio of radioArray) {
        if (radio.checked) {
            next = radio;
        };
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

