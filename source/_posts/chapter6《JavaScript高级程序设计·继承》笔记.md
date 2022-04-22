---
title: chapter6《JavaScript高级程序设计·继承》笔记
updated: 2017-07-29	20:48:17
date: 2017-05-29	14:26:24
tags: [笔记,高程]
categories: [JavaScript]
---
####  参考资料
>《JavaScript高级程序设计》

#### 对象的属性
##### 要点
* 属性分为数据属性与访问器属性
* 数据属性通过Configurable、Enumerable、Writable、Value来描述，**直接建立的属性描述默认都是true**（除去Value)
* 访问器属性通过Configurable、Enumerable、Get、Set来描述，**直接建立的属性描述默认都是true**（除去Get、Set)
* Enumerable表示能否通过for-in循环来返回属性
* Configurable表示能否删除属性，**能否修改某些属性描述符**，能否将属性改为访问器(数据)属性
* 可以通过Object.defineProperty()来定义或者修改属性
* Object.defineProperty()接受三个参数，分别是对象名，属性名，描述符对象；数据属性描述符对象只接受configurable、enumerable、writable、value四种属性中的一个或多个;访问器属性描述符对象只接受configurable、enumerable、get、set四种属性中的一个或多个
* Object.defineProperty()新增属性时，**描述符对象不指定configurable、enumerable、writable时，他们的默认值是false；不指定value、get、set时，默认值是undefined**。
*  Object.defineProperties()同时新增多个属性
*  Object.getOwnPropertyDescriptor(s) 查看属性描述符

##### Configurable
* configurable一旦指定为false，则configurable、enumerable、value、get、set将无法通过Object.defineProperty()重新配置，删除对应的属性将不产生效果（严格模式导致错误），属性将不能转换（数据与访问器之间）
* configurable一旦指定为false,此时的Writable如果是true则可以修改为false，但是不能从false改为true（只关不开）
* configurable true，writable false时，可以通过Object.defineProperty()修改value的值，直接赋值无效；configurable false，writable true时可以通过赋值直接修改value的值，通过Object.defineProperty()指定value值将会报错


##### 代码
**Object.defineProperty()只指定value不指定其他将会导致configurable、enumerable、writable都是false**，configurable为false导致该属性不能做出修改，不能调用Object.defineProperty()进行重新配置，故一般情况下需要指定configurable为true，便于之后修改enumerable、writable以及属性的值，删除属性等等

```js
var a = {}
Object.defineProperty(a, 'name', {value: 'skyline'})
a // {name: "skyline"}
a.name = 'lala'
a // {name: "skyline"}
Object.defineProperty(a, 'name', {value: 'skyline', writable: true}) // Uncaught TypeError: Cannot redefine property: name writeable是false，无法再改为true
Object.defineProperty(a, 'age', {value: '18', configurable: true})
a.age = 19 // 19
a // {name: "skyline", age: "18"}
Object.defineProperty(a, 'age', {value: '18', writable: true})
a.age = 19
a // {name: "skyline", age: 19}
```

#### 扩展、封印与冻结
##### 要点
<!--more-->
* Object.preventExtensions()禁止扩展，Object.isExtensible()检查是否可扩展
* Object.seal()封印对象，Object.isSealed()检查是否被封印
* Object.freeze()冻结对象，Object.isFrozen()检查是否被冻结
* 被冻结的对象一定被封印了；当一个被封印的对象所有自有（实例）属性的描述符writable改为false时，那么此时它也是被冻结的，通过isFrozen返回true
* 被冻结对象的访问器属性如果有set描述符，则它仍旧是可写的

*****
#### 创建对象
##### 工厂模式
工厂模式解决了创建多个对象的问题，但是没有解决对象识别问题（我的粑粑💩是谁？)

```js
function person(name) {
    var p = new Object()
    p.name = name
    return p
}

var me = person('skyline')
me.name // 'skyline'
```

##### 构造函数模式
* 按照惯例，构造函数首字母都要大写，非构造函数小写字母开头
* 构造函数主要问题是方法会在实例中各自创建，`me.say === you.say`说明了这个问题

```js
function Person(name) {
    this.name = name
    this.say = function () {
        console.log(`My name is ${this.name}`)
    }
}

var me = new Person('skyline')
var you = new Person('hahaha')
me.say() // My name is skyline
you.say() // My name is hahaha
me.say === you.say // false

```

##### 原型模式
* 通过一个名为prototype的指向一个对象的指针属性，为特定类型的所有实例共享属性和方法
* 无论何时创建新函数，都会根据一组特定的规则来为函数添加一个指向原型对象的prototype的属性
* 原型对象自动获得一个constructor属性，属性指向prototype属性所在函数的指针
* **调用构造函数创建一个新的实例之后，该实例内部包含一个指向构造函数原型对象的指针[[Prototype]]（内部属性**）。多数浏览器实现了__proto__来获取[[Prototype]]内部属性，ES6中被标准化为传统功能。可以通过isPrototypeOf()与getPrototypeOf()来确定与获取关系
* 可以通过对象实例保存原型中的值，不能通过实例重写原型中的值，实例中创建与原型中同名的属性，会屏蔽原型中的属性值。delete可以删除实例中的属性，来重新暴露原型中的属性
* hasOwnProperty()来获取自有（实例）属性
* in操作符来确定属性是否存在于对象中（包括自有与原型对象）
* for-in语句遍历所有可枚举的自有（实例）和原型属性，而Object.keys()只会收录自有属性名在数组中
* **通过直接重写prototype时，注意将构造函数属性加上constructor属性来指定构造函数，此时重新设定的constructor属性是可枚举的，js原生的是不可枚举**的，可通过Object.defineProperty()来定义

```js
function Person() {
    this.name = 'skyline'
}
Person.prototype = {
    // 	constructor: Person, // 指定构造函数
	say: function() {
		console.log(`My name is ${this.name}`)
    }
}

var skyline = new Person
skyline.say() // My name is skyline
skyline.constructor === Person // false
skyline instanceof Person // true
```

* **重写原型对象会切断新原型对象与之前已存在的实例对象之间的联系，故重写需谨慎，最好在新建函数的时候重写**
原型模式最大的问题就是引用类型的值被共享，多个实例之间会相互影响

##### 组合使用构造函数模式与原型模式
* 最常见方式，组合使用两者，构造函数模式用于实例属性，原型模式用于定义方法和共享属性

##### 动态原型模式
* 动态原型模式是将原型与自有的信息都封装在构造函数中，通过在必要情况下初始化原型，实现组合使用构造函数与原型的优点。
* **其实质就是通过检查某个应该存在的方法是否有效来决定是否初始化，if语句检查初始化后应该存在的任何属性或方法，检查其中一个即**可。
###### ☞ 错误使用
**以下是错误示例，不能再构造函数中通过对象字面量重写原型**

```js
function Person() {
    this.name = 'skyline'
    if(typeof this.say != 'function') {
        // 不能再构造函数中直接用对象字面量重写原型，重写原型对象会切断新原型对象与之前已存在的实例对象之间的联系
        Person.prototype = {
            constructor: Person, // 指定构造函数
        	say: function() {
        		console.log(`My name is ${this.name}`)
            }
        }
    }
}


var skyline = new Person
// 首次使用时，skyline的__proto__是指向
// function Person() {
    // this.name = 'skyline'
// }
// 默认产生的原型对象，而不是由字面量创建的新原型对象，调用say将会找不到
skyline.say() // VM846:1 Uncaught TypeError: skyline.say is not a function
```

###### ☞ 正确方法

```js
function Person() {
    this.name = 'skyline'
    if(typeof this.say != 'function') {
        Person.prototype.say = function() {
        	console.log(`My name is ${this.name}`)
        }
        Person.prototype.sayHi = function() {
        	console.log(`Hi!${this.name}`)
        }
    }
}

var skyline = new Person

skyline.say() // My name is skyline
```

##### 寄生构造函数模式
* 除了使用new操作符并把使用的包装函数叫做构造函数之外，此模式与工厂模式并没有区别。
* 创建的对象与构造函数之间毫无关系，并不能确定其粑粑💩（构造函数）是谁，不推荐。

```js
function Person(name) {
    var p = new Object()
    p.name = name
    return p
}

var me = new Person('skyline')
me.name // 'skyline'
me instanceof Person // false
```

##### 稳妥构造函数模式
* 稳妥对象是指没有公共属性，其方法不使用this的对象
稳妥构造函数模式与寄生构造函数类似，有两点不同一是实例方法不引用this，二是构造函数不使用new。
* 如下代码中创建了一个稳妥对象，除了say没有其他方式可以访问传入构造函数的原始数据。保证了数据的安全性。

```js
function Person(name) {
    var p = new Object()
    p.say = function() {
       console.log(`My name is ${name}`)
    }
    return p
}

var me = Person('skyline')
```

*****
#### 继承
##### 原型链
* 由于函数没有签名，ES无法实现接口继承
* **原型链继承的本质是重写原型对象，代之以一个新类型的实例**
* 通过instanceof isPrototypeOf 来判定原型与实例的关系
* 给原型添加方法需要在替换原型之后
* **通过原型链继承，不能通过字面量重写原型**
* **采用原型链继承无法避免原型中包含引用类型值所带来的问**题，同时无法向超类型构造函数传递参数，实际很少使用

```js
function Person(name) {
    // 两只眼睛两条腿
    this.eyes = 'two'
    this.feet = 'two'
    this.families = ['papa', 'mama']
}

function Man() {
    this.sex = 'male'
}
function Woman() {
    this.sex = 'female'
}
Man.prototype = new Person()
var skyline = new Man()
skyline.families.push('sister', 'grandma')
var haha = new Man()
console.log(haha.families) // ["papa", "mama", "sister", "grandma"]
```

##### 构造函数
* 为解决原型链继承引用问题而引入，同时解决了无法向超类型传递参数的问题。又称为伪造对象或经典继承
* **基本思想是子类型构造函数内部调用超类型构造函数**
* **为保证调用超类构造函数不会重写子类属性，需要先调用超类构造函数**
* 将产生方法无法复用的问题

```js
function Person(name) {
    // 两只眼睛两条腿
    this.eyes = 'two'
    this.feet = 'two'
    this.families = ['papa', 'mama']
}

function Man() {
    Person.call(this)
    this.sex = 'male'
}
var skyline = new Man()
console.log(skyline.feet) // two
```

##### 组合继承
* 又称为伪经典继承，就是组合使用原型链和构造函数模式
* 组合继承是最为常见的继承方式

```js
function Person(name) {
    // 两只眼睛两条腿
    this.name = name
    this.eyes = 'two'
    this.feet = 'two'
    this.families = ['papa', 'mama']
}

Person.prototype.say = function() {
	console.log(`My name is ${this.name}`)
}
        
function Man(name) {
    Person.call(this, name)
    this.sex = 'male'
}
Man.prototype = new Person()
var skyline = new Man('skyline')
skyline.say() // My name is skyline
skyline.families.push('sister', 'grandma')
var haha = new Man('haha')
console.log(skyline.families) // ["papa", "mama", "sister", "grandma"]
console.log(haha.families) // ["papa", "mama"]
console.log(skyline.feet) // two
```

##### 原型式继承(Object.create)
* 借助原型可以基于已有的对象创建新对象，不必因此创建自定义类型，大致思路如下代码所示
* ES5新增了Object.create方法规范了原型式继承
* 采用此方法与原型链方式相似，包含引用类型的属性始终会被共享

```js
function create(o) {
    var F = function() {}
    F.prototype = o
    return new F()
}
```

##### 寄生式继承
* 创建一个仅用于封装继承过程的函数，函数内部以某种方式来增强对象
* 与构造函数类似，方法不能复用

```js
function create(o) {
    var F = function() {}
    F.prototype = o
    return new F()
}

function createA(o) {
    var clone = create(o) // 调用任意一个可以返回对象的函数
    clone.say = function() { // 增强对象
        console.log('hahaha')
    }
    return clone // 返回对象
}
```

##### 寄生组合式继承
* 组合式继承会导致超类型构造函数的两次调用，超类型的实例属性将分别在原型中和实例中被复制而产生两组，实例属性屏蔽了原型中的属性
* 寄生组合式继承，就是通过借用构造函数来继承属性，通过原型链混成形式来继承方法 
* 最为理想的继承方式

```js
function copyPrototype(subType, superType) {
    var p = Object.create(superType.prototype)
    p.constructor = subType
    subType.prototype = p
}

function Person(name) {
    // 两只眼睛两条腿
    this.name = name
    this.eyes = 'two'
    this.feet = 'two'
    this.families = ['papa', 'mama']
}

Person.prototype.say = function() {
	console.log(`My name is ${this.name}`)
}
        
function Man(name) {
    Person.call(this, name)
    this.sex = 'male'
}

copyPrototype(Man, Person)

var skyline = new Man('skyline')
skyline.say() // My name is skyline
skyline.families.push('sister', 'grandma')
var haha = new Man('haha')
console.log(skyline.families) // ["papa", "mama", "sister", "grandma"]
console.log(haha.families) // ["papa", "mama"]
console.log(skyline.feet) // two
```

> 本文作者： Skyline(lty)
本文链接： [http://www.skyline.show/chapter6《JavaScript高级程序设计·继承》笔记.html](http://www.skyline.show/chapter6《JavaScript高级程序设计·继承》笔记.html)
版权声明： 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 3.0 许可协议](https://creativecommons.org/licenses/by-nc-sa/3.0/)。转载请注明出处！
