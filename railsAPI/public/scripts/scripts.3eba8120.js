(function(){"use strict";angular.module("yeomanNgClientApp",["ngAnimate","ngCookies","ngResource","ngSanitize","ui.router"])}).call(this),function(){"use strict";angular.module("yeomanNgClientApp").config(["$stateProvider","$urlRouterProvider",function(a,b){return b.otherwise("/login"),a.state("root",{templateUrl:"views/root.html",controller:"RootCtrl as vm"}).state("root.register",{url:"/register",views:{mainView:{templateUrl:"views/register.html",controller:"RegisterCtrl as vm"}}}).state("root.login",{url:"/login",views:{mainView:{templateUrl:"views/login.html",controller:"LoginCtrl as vm"}}}).state("root.auth",{views:{mainView:{templateUrl:"views/auth.html",controller:"AuthCtrl as vm"}}}).state("categories",{parent:"root.auth",url:"/categories",views:{authMainView:{templateUrl:"views/categories.html",controller:"CategoriesCtrl as vm"}}}).state("items",{parent:"root.auth",url:"/categories/:categoryId/items",views:{authMainView:{templateUrl:"views/items.html",controller:"ItemsCtrl as vm"}}})}]).run(["$rootScope","$state","authService",function(a,b,c){var d,e;return d=["root.register","root.login"],e=function(a){return{isPublic:function(){return _(d).contains(a.name)}}},a.$on("$stateChangeStart",function(a,d,f,g,h){return e(d).isPublic()&&c.loggedIn()?(a.preventDefault(),b.go("categories")):e(d).isPublic()||c.loggedIn()?void 0:(a.preventDefault(),b.go("root.login"))})}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("RegisterCtrl",["userResource","flashMessage","$state",function(a,b,c){var d;d=this,d.userForm={username:"hiogawa",email:"hiogawa@hiogawa.com",password:"12345678",password_confirmation:"12345678"},d.register=function(){return d.loading=!0,a.create(d.userForm).$promise.then(function(){return b.set("Registration successful","alert-success",!1),c.go("root.login")},function(){return b.set("Registration failed","alert-danger",!0),d.loading=!1})},d.cancel=function(){}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("LoginCtrl",["authService","flashMessage","$state",function(a,b,c){var d;d=this,d.sessionForm={email:"hiogawa@hiogawa.com",password:"12345678"},d.login=function(){return d.loading=!0,a.login(d.sessionForm).then(function(){return b.set("Login successful","alert-success",!1),c.go("categories")},function(){return b.set("Login failed","alert-danger",!0),d.loading=!1})},d.cancel=function(){}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("RootCtrl",["flashMessage",function(a){var b;b=this}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("AuthCtrl",function(){})}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("ItemsCtrl",["itemResource","categoryResource","flashMessage","$stateParams","$sce","$window",function(a,b,c,d,e,f){var g,h;h=this,h.category=b.show({id:d.categoryId}),g=function(){return h.items=a.index({category_id:d.categoryId})},g(),h.newItem=function(){return h.showForm=!0,h.formType="new",h.itemForm=null},h.editItem=function(a){return h.showForm=!0,h.formType="edit",h.itemForm=angular.copy(a),delete h.itemForm.picture},h.submit=function(){var b;return h.dataLoading=!0,b=function(){switch(h.formType){case"new":return a.create(h.itemForm,d.categoryId);case"edit":return a.update(h.itemForm)}}(),b.$promise.then(function(){return c.set("Successfully Submitted","alert-success",!0),h.showForm=h.dataLoading=!1,g()},function(){return c.set("Submit failed","alert-danger",!0),h.showForm=h.dataLoading=!1})},h.deleteItem=function(b){return f.confirm("Are you really sure to delete the category?")?a.destroy(b).$promise.then(function(){return c.set("item deleted","alert-success",!0),g()},function(){return c.set("item deletion failed","alert-danger",!0)}):void 0}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").controller("CategoriesCtrl",["categoryResource","flashMessage","authService","$window",function(a,b,c,d){var e,f;f=this,e=function(){return f.categories=a.index({user_id:c.getSession().userId})},e(),f.sumOfNumbersOfItemsIn=function(a){return _.foldl(a,function(a,b){return a+b.item_ids.length},0)},f.newCategory=function(){return f.showForm=!0,f.formType="new",f.categoryForm=null},f.editCategory=function(a){return f.showForm=!0,f.formType="edit",f.categoryForm=angular.copy(a)},f.submit=function(){var c;return f.loading=!0,c=function(){switch(f.formType){case"new":return a.create(f.categoryForm);case"edit":return a.update(f.categoryForm)}}(),c.$promise.then(function(){return b.set("Successfully Submitted","alert-success",!0),f.showForm=f.dataLoading=!1,e()},function(){return b.set("Submit failed","alert-danger",!0),f.showForm=f.dataLoading=!1})},f.deleteCategory=function(c){return d.confirm("Are you really sure to delete the category?")?a.destroy(c).$promise.then(function(){return b.set("category deleted","alert-success",!0),e()},function(){return b.set("category deletion failed","alert-danger",!0)}):void 0}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").service("userResource",["$resource","authService",function(a,b){var c,d;return c=a("/api/users/:userId",{userId:"@userId"},{show:{method:"GET",transformResponse:function(a){return angular.fromJson(a).user},headers:{Authorization:function(){return b.getSession().token}}},create:{method:"POST"},update:{method:"PUT",params:{userId:function(){return b.getSession().userId}},headers:{Authorization:function(){return b.getSession().token}}},destroy:{method:"DELETE",params:{userId:function(){return b.getSession().userId}},headers:{Authorization:function(){return b.getSession().token}}}}),d={show:function(a){return c.show({userId:a.id})},create:function(a){return c.create({user:_(a).pick(["username","email","password","password_confirmation"])})},update:function(a){return c.update({user:_(a).pick(["username","email","password","password_confirmation"])})},destroy:function(){return c.destroy()}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").service("authService",["$resource","$cookies",function(a,b){var c,d,e;return d=a("/api/sessions/:token",{token:"@id"},{create:{method:"POST"},destroy:{method:"DELETE"}}),c=b.getObject("session")||null,e={login:function(a){return d.create({session:_(a).pick(["email","password"])}).$promise.then(function(a){return c={userId:a.id,token:a.auth_token},b.putObject("session",c)})},logout:function(){return d.destroy({token:c.token}).$promise.then(function(){return e["delete"]()},function(){return e["delete"]()})},"delete":function(){return c=null,b.putObject("session",c)},getSession:function(){return c},loggedIn:function(){return!!this.getSession()}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").service("flashMessage",["$rootScope",function(a){var b,c;return b=0,a.$on("$stateChangeSuccess",function(){return b++,2===b?(c.close(),b=0):void 0}),c={show:!1,"class":"",message:"",set:function(a,c,d){return this.message=a,this["class"]=c,this.show=!0,b=0,d?this.flash():void 0},close:function(){return this.show=!1},flash:function(){return b++}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("userForm",function(){return{restrict:"EA",templateUrl:"scripts/directives/user_form.html",scope:{userForm:"=form",submit:"&onSubmit",cancel:"&onCancel",loading:"="}}})}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("sessionForm",function(){return{restrict:"EA",templateUrl:"scripts/directives/session_form.html",scope:{sessionForm:"=form",submit:"&onSubmit",cancel:"&onCancel",loading:"="}}})}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("flashMessageD",["flashMessage",function(a){return{restrict:"EA",templateUrl:"scripts/directives/flash_message_d.html",link:function(b,c,d){return b.flashMessage=a}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("userStatus",["userResource","authService","flashMessage","$state","$window",function(a,b,c,d,e){return{restrict:"EA",templateUrl:"scripts/directives/user_status.html",link:function(f,g,h){return f.user=a.show({id:b.getSession().userId}),f.edit=function(){return f.editing=!0,f.userForm=angular.copy(f.user)},f.editGo=function(){return f.editLoading=!0,a.update(f.userForm).$promise.then(function(){return c.set("Account updated","alert-success",!0),f.editLoading=f.editing=!1,f.user=a.show()},function(){return FlashService.set("Account update failed","alert-danger",!0),f.editLoading=f.editing=!1})},f["delete"]=function(){return e.confirm("do you really want to delete your account")?(f.loading=!0,a.destroy().$promise.then(function(){return c.set("Account deleted","alert-success",!1),b["delete"](),d.go("root.register")},function(){return c.set("Account deletion failed","alert-danger",!0),f.loading=!1})):void 0},f.logout=function(){return f.loading=!0,b.logout().then(function(){return c.set("Logout successful","alert-success",!1),d.go("root.login")},function(){return c.set("Logout Failed","alert-danger",!0),f.loading=!1})}}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").service("categoryResource",["authService","$resource",function(a,b){var c,d;return c=b("/api/categories/:categoryId",{categoryId:"@categoryId"},{index:{method:"GET",transformResponse:function(a){return angular.fromJson(a).categories},isArray:!0},show:{method:"GET",transformResponse:function(a){return angular.fromJson(a).category}},create:{method:"POST",headers:{Authorization:function(){return a.getSession().token}}},update:{method:"PUT",headers:{Authorization:function(){return a.getSession().token}}},destroy:{method:"DELETE",headers:{Authorization:function(){return a.getSession().token}}}}),d={index:function(a){return c.index(a)},show:function(a){return c.show({categoryId:a.id})},create:function(a){return c.create({category:_(a).pick(["name","description"])})},update:function(a){return c.update({categoryId:a.id},{category:_(a).pick(["name","description"])})},destroy:function(a){return c.destroy({categoryId:a.id})}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("categoryForm",function(){return{restrict:"EA",templateUrl:"scripts/directives/category_form.html",scope:{categoryForm:"=form",submit:"&onSubmit",cancel:"&onCancel",loading:"="}}})}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("itemForm",function(){return{restrict:"EA",templateUrl:"scripts/directives/item_form.html",scope:{itemForm:"=form",submit:"&onSubmit",cancel:"&onCancel",loading:"="}}})}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").service("itemResource",["authService","$resource",function(a,b){var c,d,e;return d=b("/api/items/:itemId",{itemId:"@itemId"},{index:{method:"GET",transformResponse:function(a){return angular.fromJson(a).items},isArray:!0},show:{method:"GET",transformResponse:function(a){return angular.fromJson(a).item}},create:{method:"POST",transformRequest:angular.identity,headers:{Authorization:function(){return a.getSession().token},"Content-Type":void 0}},update:{method:"PUT",transformRequest:angular.identity,headers:{Authorization:function(){return a.getSession().token},"Content-Type":void 0}},destroy:{method:"DELETE",headers:{Authorization:function(){return a.getSession().token}}}}),c=function(a){var b;return b=new FormData,_(a).mapObject(function(a,c){return _.isObject(a)?_(a).mapObject(function(a,d){return b.append(""+c+"["+d+"]",a)}):b.append(c,a)}),b},e={index:function(a){return d.index(a)},show:function(){return d.show()},create:function(a,b){var e;return e=c({category_id:b,item:_(a).pick(["word","sentence","meaning","picture"])}),d.create(e)},update:function(a){return d.update({itemId:a.id},c({category_id:a.category.id,item:_(a).pick(["word","sentence","meaning","picture"])}))},destroy:function(a){return d.destroy({itemId:a.id})}}}])}.call(this),function(){"use strict";angular.module("yeomanNgClientApp").directive("myFileUpload",["$parse",function(a){return{restrict:"EA",link:function(b,c,d){return c.bind("change",function(){return b.$apply(function(){return a(d.myFileUpload).assign(b,c[0].files[0])})})}}}])}.call(this),angular.module("yeomanNgClientApp").run(["$templateCache",function(a){"use strict";a.put("views/auth.html",'<div user-status="user-status"></div><div ui-view="authMainView"></div>'),a.put("views/categories.html",'<a ng-click="vm.newCategory()" class="btn btn-default btn-sm">New category</a><table class="table table-striped"><thead><tr><th><category>Name</category><span class="badge pull-right">{{ vm.sumOfNumbersOfItemsIn(vm.categories) }}</span></th><th>Actions</th></tr></thead><tbody><tr ng-repeat="category in vm.categories"><td><span>{{ category.name }}</span><span class="badge pull-right">{{ category.item_ids.length }}</span></td><td><div class="btn-group"><a ui-sref="items({categoryId: {{category.id}}})" class="btn btn-info"><span>Show items</span><span class="glyphicon glyphicon-list-alt"></span></a><a ng-click="vm.editCategory(category)" class="btn btn-warning"><span>Edit</span><span class="glyphicon glyphicon-pencil"></span></a><a ng-click="vm.deleteCategory(category)" class="btn btn-danger"><span>Delete</span><span class="glyphicon glyphicon-trash"></span></a></div></td></tr></tbody></table><div ng-cloak="ng-cloak" ng-show="vm.showForm" category-form="category-form" form="vm.categoryForm" on-submit="vm.submit()" on-cancel="vm.showForm=false" loading="vm.dataLoading"></div>'),a.put("views/items.html",'<p>items in {{ vm.category.name }}</p><a ui-sref="categories" class="btn btn-default btn-sm"> Back to Categories</a><a ng-click="vm.newItem()" class="btn btn-default btn-sm">New Item</a><div ng-cloak="ng-cloak" ng-show="vm.showForm" item-form="item-form" form="vm.itemForm" on-submit="vm.submit()" on-cancel="vm.showForm=false" loading="vm.loading"></div><div class="row"><div class="col-sm-9"><div id="items-list"><table class="table table-striped"><thead><tr><th>Word and Meaning</th><th>Sentence</th><th>Actions</th></tr></thead><tbody><tr ng-repeat="item in vm.items"><td class="word-meaning"><div class="h4"> {{ item.word }}</div><div class="small"> {{ item.meaning }}</div></td><td class="sentence">{{ item.sentence }}</td><td class="actions"><div class="btn-group"><a ng-click="vm.editItem(item)" class="btn btn-warning"><span>Edit</span><span class="glyphicon glyphicon-pencil"></span></a><a ng-click="vm.deleteItem(item)" class="btn btn-danger"><span>Delete</span><span class="glyphicon glyphicon-trash"></span></a></div></td></tr></tbody></table></div></div><div class="col-sm-3"><div id="images-list"><a ng-repeat="item in vm.items" ng-href="{{ item.picture }}" class="magnific-popup-img"><img ng-src="{{ item.picture }}" class="img-thumbnail"><div ng-init="vm.initMagnificPopup()" class="fake"></div></a></div></div></div>'),a.put("views/login.html",'<div session-form="session-form" form="vm.sessionForm" on-submit="vm.login()" on-cancel="vm.cancel()" loading="vm.loading"></div>'),a.put("views/register.html",'<div user-form="user-form" form="vm.userForm" on-submit="vm.register()" on-cancel="vm.cancel()" loading="vm.loading"></div>'),a.put("views/root.html",'<div class="container-fluid"><div class="btn-group btn-group-sm"><a ui-sref="root.register" class="btn btn-default">root.register</a><a ui-sref="root.login" class="btn btn-default">root.login</a><a ui-sref="categories" class="btn btn-default">categories</a><a ui-sref="items({categoryId: 1})" class="btn btn-default">items({categoryId: 1})</a></div><p>views</p><div flash-message-d="flash-message-d"></div><div ui-view="mainView"></div></div>'),a.put("scripts/directives/category_form.html",'<form name="form" ng-submit="submit()" novalidate><div class="form-group"><label>Name</label><input ng-model="categoryForm.name" required class="form-control"></div><div class="form-group"><label>Description</label><input ng-model="categoryForm.description" class="form-control"></div><div class="form-actions"><button type="submit" ng-disabled="form.$invalid || loading" class="btn btn-primary">Submit</button><a ng-click="cancel()" class="btn btn-link">Cancel</a><i ng-if="loading" class="fa fa-spinner fa-spin"></i></div></form>'),a.put("scripts/directives/flash_message_d.html",'<div ng-show="flashMessage.show" ng-class="flashMessage.class" class="alert"><span>{{ flashMessage.message }}</span><div ng-click="flashMessage.close()" class="btn btn-default pull-right"><i class="fa fa-remove"></i></div></div>'),a.put("scripts/directives/item_form.html",'<form name="form" ng-submit="submit()" novalidate><div class="form-group"><label>Word</label><input ng-model="itemForm.word" required class="form-control"></div><div class="form-group"><label>Meaning</label><input ng-model="itemForm.meaning" class="form-control"></div><div class="form-group"><label>Sentence</label><input ng-model="itemForm.sentence" class="form-control"></div><div class="form-group"><label>Picture</label><input my-file-upload="itemForm.picture" type="file"></div><div class="form-actions"><button type="submit" ng-disabled="form.$invalid || loading" class="btn btn-primary">Submit</button><a ng-click="cancel()" class="btn btn-link">Cancel</a><i ng-if="loading" class="fa fa-spinner fa-spin"></i></div></form>'),a.put("scripts/directives/session_form.html",'<form name="form" ng-submit="submit()" novalidate><div class="form-group"><label>Email address</label><input ng-model="sessionForm.email" type="email" required class="form-control"></div><div class="form-group"><label>Password</label><input ng-model="sessionForm.password" type="password" required minlength="8" class="form-control"></div><div class="form-actions"><button type="submit" ng-disabled="form.$invalid || loading" class="btn btn-primary">Submit </button><a ng-click="cancel()" class="btn btn-link">Cancel</a><i ng-if="loading" class="fa fa-spinner fa-spin"></i></div></form>'),a.put("scripts/directives/user_form.html",'<form name="form" ng-submit="submit()" novalidate><div class="form-group"><label>User name</label><input ng-model="userForm.username" minlength="5" maxlength="20" required class="form-control"></div><div class="form-group"><label>Email address</label><input ng-model="userForm.email" type="email" required class="form-control"></div><div class="form-group"><label>Password (longer than 8 characters)</label><input ng-model="userForm.password" type="password" required minlength="8" class="form-control"></div><div class="form-group"><label>Password Confirmation</label><input ng-model="userForm.password_confirmation" type="password" required minlength="8" class="form-control"></div><div class="form-actions"><button type="submit" ng-disabled="form.$invalid || loading || userForm.password != userForm.password_confirmation" class="btn btn-primary">Submit</button><a ng-click="cancel()" class="btn btn-link">Cancel</a><i ng-if="loading" class="fa fa-spinner fa-spin"></i></div></form>'),a.put("scripts/directives/user_status.html",'<p>user: <em>{{ user.username }}</em></p><div class="btn-group btn-group-sm"><a ng-click="logout()" class="btn btn-default">Logout</a><a ng-click="edit()" class="btn btn-default">Edit account</a><a ng-click="delete()" class="btn btn-default">Delete account</a><i ng-if="loading" class="fa fa-spinner fa-spin"></i></div><div ng-cloak="ng-cloak" ng-show="editing" user-form="user-form" form="userForm" on-submit="editGo()" on-cancel="editing=false" loading="editLoading"></div>')}]);