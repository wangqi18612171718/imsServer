(function ($, window) {
	$.fn.acemenu = function (options) {
		// 默认参数
		var defaults = {
			//绑定对应展示的TabID
			menuTabID: "",
			//数据对象数据格式 title、icon、url、children[]
			data:null
		};
		//为了给自定义方法用
		var _self = $(this);
		_self.addClass("nav").addClass("nav-list");
		// 插件配置
		var opt = $.extend(defaults, options);
	  
		var _init = function (target,data) {
			$.each(data, function (i, item) {
				var li = $("<li></li>");
				var a = $("<a></a>");
				var i = $("<i></i>");
				var span = $("<span style='padding:3px;'></span>");
				target.append(li);
				if (item.children && item.children.length > 0) {
					li.append(a);
					//li.addClass("active").addClass("open");
					if (target.hasClass("nav") && target.hasClass("nav-list")) {
					//是第一级菜单
					} else {
					//是子菜单
					//a.append("<i class=\"icon-double-angle-right\"></i>")
					}
					a.addClass("dropdown-toggle");
					if (item.url == "") {
						a.attr("href", "javascript:void(0);");
					} else {
						a.attr("href", basePath+item.url).addClass("tabli");
					}
					a.append(i);
					i.addClass(item.icon);
					a.append(span);
					span.addClass("menu-text").text(item.title);
					var b = $("<b></b>");
					b.addClass("arrow").addClass("icon-angle-down");
					a.append(b);
					var ul = $("<ul></ul>");
					ul.addClass("submenu");
					li.append(ul);
					_init(ul, item.children);
				} else {
					li.append(a);
					if (item.url == "") {
						a.attr("href", "javascript:void(0);");
					} else {
						a.attr("href", basePath+item.url).addClass("tabli");
					}
					if (target.hasClass("nav") && target.hasClass("nav-list")) {
					//是第一级菜单
					} else {
						//是子菜单
						a.append("<i class=\"icon-double-angle-right\"></i>")
					}
					a.append(i);
					i.addClass(item.icon);
					a.append(span);
					span.addClass("menu-text").text(item.title);
				}
			});
		}
		if (opt.data) {
			_init(_self, opt.data);
			//事件处理
			$(_self).find(".dropdown-toggle").bind("click", function () {
				$.each($(_self).find(".dropdown-toggle"), function () {
					$(this).next().hide();
				})
				$(this).next().animate({
					height: 'toggle'
				});
			});
			//debugger
			//打开第一个,默认首页
//			$(_self).find(".dropdown-toggle").first().next().animate({
//				height: 'toggle'
//			});
//			$(_self).find(".dropdown-toggle").first().next().find("li").first().addClass("active");
			$("#menu").find("li").first().addClass("active");
			
			
			var tabA = $(_self).find(".tabli").first();
			$("#" + opt.menuTabID).aceaddtab({
				icon: tabA.find("i").last().attr("class"),
				title: tabA.find("span").first().text(),
				url: tabA.attr("href")
			});
			//打开Tab
			$(_self).find(".tabli").bind("click", function () {
				$.each($(_self).find(".tabli"), function () {
					$(this).parent().removeClass("active");
				})
				$(this).parent().addClass("active");
			  
				$("#" + opt.menuTabID).aceaddtab({
					icon: $(this).find("i").last().attr("class"),
					title: $(this).find("span").first().text(),
					url: $(this).attr("href")
				});
				return false;
			});
		}
  //-----------------------

		return this;
	}
})(jQuery, window);