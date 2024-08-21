// HashMap 主要功能
const HashMap = function () {
    let mapObj = {};
    return {
        'put': function (key, value) {
            mapObj[key] = value;
        },
        'keys': function () {
            return Object.keys(mapObj);
        },
        'contains': function (key) {
            for (let k in mapObj) {
                if (k === key) {
                    return true;
                }
            }
            return false;
        },
        'get': function (key) {
            return mapObj[key];
        },
        'clear': function () {
            mapObj = {};
        }
    };
};

// 互動功能
window.onload = function () {
    let map = new HashMap();

    document.getElementById('buttonPut').onclick = function () {
        inputKey = document.getElementById('inputKey');
        inputValue = document.getElementById('inputValue');
        if (!inputKey.value.trim() || map.contains(inputKey.value)) {
            return;
        }
        map.put(inputKey.value, inputValue.value);
        print();

    }
    document.getElementById('buttonClear').onclick = function () {
        inputKey.value = '';
        inputValue.value = '';
        map.clear();
        print();
    }

    const print = function () {
        let result = '';
        const key = map.keys();
        for (let i = 0; i < key.length; i++) {
            result += '　　' + key[i] + '：' + map.get(key[i]) + '<br>';
        }
        document.getElementById('result').innerHTML = result;
    }
}