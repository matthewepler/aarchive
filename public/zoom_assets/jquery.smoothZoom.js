/*
	Smooth Zoom Pan - jQuery Image Viewer
 	Copyright (c) 2011 Ramesh Kumar
	http://codecanyon.net/user/VF
	
	Version: 1.2 
	31 OCT 2011
	
	Built using:
	jQuery 		version:1.6.2	http://jquery.com/
	Modernizr 	version:2.0.6	http://www.modernizr.com/
	MouseWheel	version:3.0.2	http://brandonaaron.net/code/mousewheel/docs
	
*/

(function ($) {

	function zoomer($image, params) {

		var op = $.extend({}, {

			//Defaults
			width					: '',
			height					: '',

			initial_ZOOM			: '',
			initial_POSITION		: '',

			animation_SMOOTHNESS	: 5.5,
			animation_SPEED			: 5.5,

			zoom_MAX				: 800,
			zoom_MIN				: '',
			zoom_OUT_TO_FIT			: 'YES',
			zoom_BUTTONS_SHOW		: 'YES',

			pan_BUTTONS_SHOW		: 'YES',
			pan_LIMIT_BOUNDARY		: 'YES',

			button_SIZE				: 18,
			button_COLOR			: '#FFFFFF',
			button_BG_COLOR			: '#000000',
			button_BG_TRANSPARENCY	: 55,
			button_ICON_IMAGE		: 'http://itp.nyu.edu/~mae383/sinatra/final/public/zoom_assets/icons.png',
			button_AUTO_HIDE		: 'NO',
			button_AUTO_HIDE_DELAY	: 1,
			button_ALIGN			: 'bottom right',
			button_MARGIN			: 10,
			button_ROUND_CORNERS	: 'YES',

			mouse_DRAG				: 'YES',
			mouse_WHEEL				: 'YES',
			mouse_WHEEL_CURSOR_POS	: 'YES',
			mouse_DOUBLE_CLICK		: 'YES',

			background_COLOR		: '#FFFFFF',
			border_SIZE				: 1,
			border_COLOR			: '#000000',
			border_TRANSPARENCY		: 10,

			container				: '',
			max_WIDTH				: '',
			max_HEIGHT				: '',
			full_BROWSER_SIZE		: 'NO',
			full_BROWSER_WIDTH_OFF	: 0,
			full_BROWSER_HEIGHT_OFF	: 0

		}, params);

		//Option values verified if needed
		var sW = op.width;
		var sH = op.height;

		var w_max = op.max_WIDTH;
		var h_max = op.max_HEIGHT;

		var init_zoom = op.initial_ZOOM / 100;
		var init_pos = op.initial_POSITION.split(' ');

		var zoom_max = op.zoom_MAX / 100;
		var zoom_min = op.zoom_MIN / 100;
		var zoom_fit = op.zoom_OUT_TO_FIT ? op.zoom_OUT_TO_FIT === true ? true : op.zoom_OUT_TO_FIT.toLowerCase() == 'yes' || op.zoom_OUT_TO_FIT.toLowerCase() == 'true' ? true : false : false;
		var zoom_speed = 1 + ((op.animation_SPEED + 1) / 20);
		var zoom_show = op.zoom_BUTTONS_SHOW ? op.zoom_BUTTONS_SHOW === true ? true : op.zoom_BUTTONS_SHOW.toLowerCase() == 'yes' || op.zoom_BUTTONS_SHOW.toLowerCase() == 'true' ? true : false : false;

		var pan_speed_o = op.animation_SPEED;
		
		var pan_show = op.pan_BUTTONS_SHOW ? op.pan_BUTTONS_SHOW === true ? true : op.pan_BUTTONS_SHOW.toLowerCase() == 'yes' || op.pan_BUTTONS_SHOW.toLowerCase() == 'true' ? true : false : false;
		var pan_limit = op.pan_LIMIT_BOUNDARY ? op.pan_LIMIT_BOUNDARY === true ? true : op.pan_LIMIT_BOUNDARY.toLowerCase() == 'yes' || op.pan_LIMIT_BOUNDARY.toLowerCase() == 'true' ? true : false : false;

		var bu_size = parseInt(op.button_SIZE/2)*2;
		var bu_color = op.button_COLOR;
		var bu_bg = op.button_BG_COLOR;
		var bu_bg_alpha = op.button_BG_TRANSPARENCY / 100;
		var bu_icon = op.button_ICON_IMAGE;
		var bu_auto = op.button_AUTO_HIDE ? op.button_AUTO_HIDE === true ? true : op.button_AUTO_HIDE.toLowerCase() == 'yes' || op.button_AUTO_HIDE.toLowerCase() == 'true' ? true : false : false;
		
		var bu_delay = op.button_AUTO_HIDE_DELAY * 1000;
		var bu_align = op.button_ALIGN.toLowerCase().split(' ');
		var bu_margin = op.button_MARGIN;
		var bu_round = op.button_ROUND_CORNERS ? op.button_ROUND_CORNERS === true ? true : op.button_ROUND_CORNERS.toLowerCase() == 'yes' || op.button_ROUND_CORNERS.toLowerCase() == 'true' ? true : false : false;

		var mouse_drag = op.mouse_DRAG ? op.mouse_DRAG === true ? true : op.mouse_DRAG.toLowerCase() == 'yes' || op.mouse_DRAG.toLowerCase() == 'true' ? true : false : false;
		var mouse_wheel = op.mouse_WHEEL ? op.mouse_WHEEL === true ? true : op.mouse_WHEEL.toLowerCase() == 'yes' || op.mouse_WHEEL.toLowerCase() == 'true' ? true : false : false;
		var mouse_wheel_cur = op.mouse_WHEEL_CURSOR_POS ? op.mouse_WHEEL_CURSOR_POS === true ? true : op.mouse_WHEEL_CURSOR_POS.toLowerCase() == 'yes' || op.mouse_WHEEL_CURSOR_POS.toLowerCase() == 'true' ? true : false : false;
		var mouse_dbl_click = op.mouse_DOUBLE_CLICK ? op.mouse_DOUBLE_CLICK === true ? true : op.mouse_DOUBLE_CLICK.toLowerCase() == 'yes' || op.mouse_DOUBLE_CLICK.toLowerCase() == 'true' ? true : false : false;

		var ani_smooth = Math.max(1.5, op.animation_SMOOTHNESS - 1);
		var bg_color = op.background_COLOR;
		var bord_size = op.border_SIZE;
		var bord_color = op.border_COLOR;
		var bord_alpha = op.border_TRANSPARENCY / 100;

		var full_BROWSER_SIZE = op.full_BROWSER_SIZE ? op.full_BROWSER_SIZE === true ? true : op.full_BROWSER_SIZE.toLowerCase() == 'yes' || op.full_BROWSER_SIZE.toLowerCase() == 'true' ? true : false : false;

		var full_BROWSER_WO = op.full_BROWSER_WIDTH_OFF;
		var full_BROWSER_HO = op.full_BROWSER_HEIGHT_OFF;

		//Vars for inner operation				
		var rF = 1;
		var rA = 1;
		var iW = 0;
		var iH = 0;
		var tX = 0;
		var tY = 0;
		var oX = 0;
		var oY = 0;
		var fX = 0;
		var fY = 0;
		var dX = 0;
		var dY = 0;

		var _x;
		var _y;
		var _w;
		var _h;
		var _sc = 0;

		var transOffX = 0;
		var transOffY = 0;
		var focusOffX = 0;
		var focusOffY = 0;
		var dClickedX = 0;
		var dClickedY = 0;

		var zDown = false;
		var drDown = false;
		var pixTol = .5;
		var offX = 0;
		var offY = 0;
		var mouseX = 0;
		var mouseY = 0;

		var _iconLoaded = false;
		var _mainLoaded = false;
		var _playing = false;
		var _dragging = false;
		var _onfocus = false;
		var _moveCursor = false;
		var _wheel = false;
		var _recent = 'zoomOut';

		
		var cFlag = {
			_zi: false,
			_zo: false,
			_ml: false,
			_mr: false,
			_mu: false,
			_md: false,
			_rs: false,
			_nd: false
		};
		
		var $holder;
		var $hitArea;	
		var $controls;
		var buttons = [];
		
		var buttons_total;		
		var cButtId = 0;
		var cBW;
		var cBH;

		var pan_speed;
		var auto_timer;
		var ani_timer;
		var ani_end;

		var orig_style;
		var loadingLoop;
		var map_coordinates = [];
		var mapAreas;
		var icons;
		var border = [];
		
		var dbl_click_dir = 1;
		var id = $image.attr('id');

		var init = function () {

			//Store the default image properties so that it can be reverted back when plugin needs to be destroyed
			orig_style = getStyle($image);

			//IE 6 Image tool bar disabled
			$image.attr('galleryimg', 'no');

			//Wrap a container for image or get the container if specified through options:
			$holder = op.container == '' ? $image.wrap('<div></div>').parent() : $('#' + op.container);
			$hitArea = $('<div></div>').appendTo($holder).css({
				position: 'absolute',
				'z-index': 1,
				top: '0px',
				left: '0px',
				'width': '100%',
				'height': '100%'
			});

			if (full_BROWSER_SIZE) {
				$('html').css('height', '100%');
				$('body').css({
					'width': '100%',
					'height': '100%',
					'margin': '0px'
				});
				
				if (String(full_BROWSER_WO).indexOf('%') > -1 ){
					sW = parseInt($('body').innerWidth()*((100-parseInt(full_BROWSER_WO))/100));
				} else {
					sW = $('body').innerWidth() - full_BROWSER_WO;
				}
				
				if (String(full_BROWSER_HO).indexOf('%') > -1 ){
					sH = parseInt($('body').innerHeight()*((100-parseInt(full_BROWSER_HO))/100));
				} else {
					sH = $('body').innerHeight() - full_BROWSER_HO;
				}
				
				if (w_max !== 0 && w_max !== '') sW = Math.min(w_max, sW);
				if (h_max !== 0 && h_max !== '') sH = Math.min(h_max, sH);
				$(window).bind('resize.smoothZoom' + id, windowResize);

			} else {

				if (sW === '' || sW === 0) {
					sW = Math.max($holder.parent().width(), 100);
					if (w_max !== 0 && w_max !== '') sW = Math.min(sW, w_max);
				} else if (!isNaN(sW) || String(sW).indexOf('px') > -1) {
					sW = parseInt(sW);
					if (w_max !== 0 && w_max !== '') sW = Math.min(sW, w_max);
				} else if (String(sW).indexOf('%') > -1) {
					sW = $holder.parent().width() * (sW.split('%')[0] / 100);
					if (w_max !== 0 && w_max !== '') sW = Math.min(sW, w_max);
				} else {
					sW = 100;
				}
				if (sH === '' || sH === 0) {
					sH = Math.max($holder.parent().height(), 100);
					if (h_max !== 0 && h_max !== '') sH = Math.min(sH, h_max);
				} else if (!isNaN(sH) || String(sH).indexOf('px') > -1) {
					sH = parseInt(sH);
					if (h_max !== 0 && h_max !== '') sH = Math.min(sH, h_max);
				} else if (String(sH).indexOf('%') > -1) {
					sH = $holder.parent().height() * (sH.split('%')[0] / 100);
					if (h_max !== 0 && h_max !== '') sH = Math.min(sH, h_max);
				} else {
					sH = 100;
				}
			}

			//Add Image container properties
			$holder.css({
				'-moz-user-select': 'none',
				'-khtml-user-select': 'none',
				'-webkit-user-select': 'none',
				'user-select': 'none',
				'width': sW + 'px',
				'height': sH + 'px',
				'position': 'relative',
				'overflow': 'hidden',
				'text-align': 'left',
				'background-color': op.background_COLOR
			}).addClass('noSel');


			//Add border if needed
			if (bord_size > 0) {
				border[0] = $('<div></div>').appendTo($holder).css({
					position: 'absolute',
					width: bord_size + 'px',
					height: sH + 'px',
					top: 0 + 'px',
					left: 0 + 'px',
					'z-index': 3,
					'background-color': bord_color,
					'opacity': bord_alpha
				});
				border[1] = $('<div></div>').appendTo($holder).css({
					position: 'absolute',
					width: bord_size + 'px',
					height: sH + 'px',
					top: 0 + 'px',
					left: (sW - bord_size) + 'px',
					'z-index': 4,
					'background-color': bord_color,
					'opacity': bord_alpha
				});
				border[2] = $('<div>&nbsp;</div>').appendTo($holder).css({
					position: 'absolute',
					width: sW - (bord_size * 2) + 'px',
					height: bord_size + 'px',
					top: 0 + 'px',
					left: bord_size + 'px',
					'z-index': 5,
					'background-color': bord_color,
					'opacity': bord_alpha,
					'line-height': '1px'
				});
				border[3] = $('<div>&nbsp;</div>').appendTo($holder).css({
					position: 'absolute',
					width: sW - (bord_size * 2) + 'px',
					height: bord_size + 'px',
					top: (sH - bord_size) + 'px',
					left: bord_size + 'px',
					'z-index': 6,
					'background-color': bord_color,
					'opacity': bord_alpha,
					'line-height': '1px'
				});
			}

			//Get Image maps if exists
			if ($image.attr('usemap') != undefined) {
				mapAreas = $("map[name='" + ($image.attr('usemap').split('#').join('')) + "']").children('area');
				mapAreas.each(function () {
					$(this).css('cursor', 'pointer');
					map_coordinates.push($(this).attr('coords').split(','));
				});
			}

			//Set a preloader loop
			loadingLoop = new setLoadingLoop($holder);

			//Preload the icon graphics
			icons = new Image();
			icons.src = bu_icon;
			if (!icons.complete) {
				$(icons).bind('load.smoothZoom onreadystatechange.smoothZoom', function () {
					_iconLoaded = true;
					_mainLoaded ? setUp() : "";
				});
			} else {
				_iconLoaded = true;
				_mainLoaded ? setUp() : "";
			}

			//Preload Main image
			$image.hide();
			$image.one('load', function () {
				_mainLoaded = true;
				_iconLoaded ? setUp() : "";
			}).each(function () {
				if (this.complete) {
					$(this).trigger('load');
				}
			});
		}


		//Start the measurements when image loaded
		var setUp = function () {
			orig_style = getStyle($image);

			$image.removeAttr('width');
			$image.removeAttr('height');

			iW = $image.width();
			iH = $image.height();

			//Initially the image needs to be resized to fit container. To do so, first measure the scaledown ratio	
			checkRatio();

			//If NO Minimum zoom value set
			if (zoom_min == 0 || init_zoom != 0) {
				rA = _sc = init_zoom != '' ? init_zoom : rF;
				
			//If Minimum zoom value set
			} else {
				rA = _sc = rF = zoom_min;
			}

			//Width and Height to be applied to the image
			_w = _sc * iW;
			_h = _sc * iH;

			//Resize the image and position it centered inside the wrapper
			if (init_pos == '') {
				_x = tX = (sW - _w) / 2;
				_y = tY = (sH - _h) / 2;
			} else {
				_x = tX = (sW / 2) - parseInt(init_pos[0]) * _sc;
				_y = tY = (sH / 2) - parseInt(init_pos[1]) * _sc;
				oX = (tX - ((sW - _w) / 2)) / (_w / sW);
				oY = (tY - ((sH - _h) / 2)) / (_h / sH);
			}

			//Pan speed will vary according to application dimension
			pan_speed = Math.max(1, ((sW + sH) / 500)) - 1 + (pan_speed_o * pan_speed_o / 4) + 2;
			if (!pan_limit || _moveCursor || init_zoom != rF) $image.css('cursor', 'move'), $hitArea.css('cursor', 'move');
			
			//Start displaying the image
			$image.css({
				position: 'relative',
				'z-index': 2,
				left: '0px',
				top: '0px'
			}).hide().fadeIn(500, function () {
				loadingLoop.destroy();				
				loadingLoop = null;				
			});
			
			//Create Control buttons and events
			addControls();
			
			//Apply initial transformation
			Animate();
		}

		//Storing the original style of image (needed only when destroying)
		var getStyle = function (el) {
			return {
				prop_origin: [prop_origin, prop_origin !== false && prop_origin !== undefined ? el.css(prop_origin) : null],
				prop_transform: [prop_transform, prop_transform !== false && prop_transform !== undefined ? el.css(prop_transform) : null],
				'position': ['position', el.css('position')],
				'z-index': ['z-index', el.css('z-index')],
				'cursor': ['cursor', el.css('cursor')],
				'left': ['left', el.css('left')],
				'top': ['top', el.css('top')],
				'width': ['width', el.css('width')],
				'height': ['height', el.css('height')]
			};
		}

		//Find the scale ratios
		var checkRatio = function () {
			if (iW == sW && iH == sH) {
				rF = 1;
			} else if (iW < sW && iH < sH) {
				rF = sW / iW;
				if (zoom_fit) {
					if (rF * iH > sH) {
						rF = sH / iH;
					}
				} else {
					if (rF * iH < sH) {
						rF = sH / iH;
					}
					if (sW / iW !== sH / iH) {
						_moveCursor = true;
						$image.css('cursor', 'move'), $hitArea.css('cursor', 'move');
					}
				}
			} else {
				rF = sW / iW;
				if (zoom_fit) {
					if (rF * iH > sH) {
						rF = sH / iH;
					}
				} else {
					if (rF * iH < sH) {
						rF = sH / iH;
					}
					if (sW / iW !== sH / iH) {
						_moveCursor = true;
						$image.css('cursor', 'move'), $hitArea.css('cursor', 'move');
					}
				}
			}
		}

		//The navigation buttons and events added
		var addControls = function () {
			var iSize = 50,
				sDiff = 2,
				bSpace = 3,
				mSize = Math.ceil(bu_size / 4),
				iconOff = bu_size <16 ? 50 : 0;

			//Show all buttons			
			if (pan_show) {
				if (zoom_show) {
					cBW = parseInt(bu_size + (bu_size * .85) + ((bu_size - sDiff) * 3) + (bSpace * 2) + (mSize * 2));
				} else {
					cBW = parseInt(((bu_size - sDiff) * 3) + (bSpace * 2) + (mSize * 2));					
				}
				cBH = parseInt(((bu_size - sDiff) * 3) + (bSpace * 2) + (mSize * 2));

			//Show zoom buttons only			
			} else {
				if (zoom_show) {
					cBW = parseInt(bu_size + mSize * 2);
					cBH = parseInt(bu_size * 2 + mSize * 3);
					cBW = parseInt(cBW / 2) * 2;
					cBH = parseInt(cBH / 2) * 2;
				} else {
					cBW = 0;
					cBH = 0;
				}
			}


			var pOff = (iSize - bu_size) / 2;
			var resetCenter = {
				x: cBW - ((bu_size - (pan_show ? sDiff : 0)) * 2) - mSize - bSpace,
				y: (cBH / 2) - ((bu_size - (pan_show ? sDiff : 0)) / 2)
			};

			//Buttons Container		
			$controls = $('<div></div>').appendTo($holder).css({
				position: 'absolute',
				width: cBW + 'px',
				height: cBH + 'px',
				'z-index': 7
			}).addClass('noSel');

			//Align button set as per settings
			if (bu_align[0] == 'top') {
				$controls.css('top', bu_margin + 'px');
			} else if (bu_align[0] == 'center') {
				$controls.css('top', parseInt((sH - cBH) / 2) + 'px');
			} else {
				$controls.css('bottom', bu_margin + 'px');
			}
			if (bu_align[1] == 'right') {
				$controls.css('right', bu_margin + 'px');
			} else if (bu_align[1] == 'center') {
				$controls.css('left', parseInt((sW - cBW) / 2) + 'px');
			} else {
				$controls.css('left', bu_margin + 'px');
			}

			var $controlsBg = $('<div id="controlsBg"></div>').appendTo($controls).css({
				position: 'relative',
				width: '100%',
				height: '100%',
				'opacity': bu_bg_alpha,
				'z-index': 1
			}).addClass('noSel');

			//Make the corners rounded
			if (use_bordRadius || !use_pngTrans || !bu_round) {
				$controlsBg.css({
					'opacity': bu_bg_alpha,
					'background-color': bu_bg
				});
				if (use_bordRadius && bu_round) {
					$controlsBg.css({
						'-moz-border-radius': (iconOff>0 ? 4 : 5) +'px',
						'-webkit-border-radius': (iconOff>0 ? 4 : 5) +'px',
						'border-radius': (iconOff>0 ? 4 : 5) +'px',
						'-khtml-border-radius': (iconOff>0 ? 4 : 5) +'px'
					});
				}

			} else {
				roundBG($controlsBg, 'cBg', cBW, cBH, iconOff>0 ? 4 : 5, 375, bu_bg, bu_icon, 1, iconOff? 50 : 0);
			}

			//Generating Button properties	(7 buttons)			
			buttons[0] = {
				_var: '_zi',
				l: mSize,
				t: pan_show ? (cBH - (bu_size * 2) - (bSpace * 2) + 2) / 2 : mSize,
				w: bu_size,
				h: bu_size,
				bx: -pOff,
				by: -pOff-iconOff
			};

			buttons[1] = {
				_var: '_zo',
				l: mSize,
				t: pan_show ? ((cBH - (bu_size * 2) - (bSpace * 2) + 2) / 2) + bu_size + (bSpace * 2) - 2 : cBH - bu_size - mSize,
				w: bu_size,
				h: bu_size,
				bx: -iSize - pOff,
				by: -pOff-iconOff
			};
			
			buttons[2] = {
				_var: '_mr',
				l: resetCenter.x - (bu_size - sDiff) - bSpace,
				t: resetCenter.y,
				w: bu_size - sDiff,
				h: bu_size - sDiff,
				bx: -(sDiff / 2) - iSize * 2 - pOff,
				by: -(sDiff / 2) - pOff - iconOff
			};

			buttons[3] = {
				_var: '_ml',
				l: resetCenter.x + (bu_size - sDiff) + bSpace,
				t: resetCenter.y,
				w: bu_size - sDiff,
				h: bu_size - sDiff,
				bx: -(sDiff / 2) - iSize * 3 - pOff,
				by: -(sDiff / 2) - pOff - iconOff
			};

			buttons[4] = {
				_var: '_mu',
				l: resetCenter.x,
				t: resetCenter.y + (bu_size - sDiff) + bSpace,
				w: bu_size - sDiff,
				h: bu_size - sDiff,
				bx: -(sDiff / 2) - iSize * 4 - pOff,
				by: -(sDiff / 2) - pOff - iconOff
			};

			buttons[5] = {
				_var: '_md',
				l: resetCenter.x,
				t: resetCenter.y - (bu_size - sDiff) - bSpace,
				w: bu_size - sDiff,
				h: bu_size - sDiff,
				bx: -(sDiff / 2) - iSize * 5 - pOff,
				by: -(sDiff / 2) - pOff - iconOff
			};

			buttons[6] = {
				_var: '_rs',
				l: resetCenter.x,
				t: resetCenter.y,
				w: bu_size - sDiff,
				h: bu_size - sDiff,
				bx: -(sDiff / 2) - iSize * 6 - pOff,
				by: -(sDiff / 2) - pOff - iconOff
			};
			

			buttons_total = buttons.length;
			for (var i = 0; i < buttons_total; i++) {
				buttons[i].$ob = $('<div></div>').appendTo($($controls)).css({
					'display': i<2 ? zoom_show ? 'inherit' : 'none' : pan_show ? 'inherit' : 'none',
					'position': 'absolute',
					'left': buttons[i].l - 1 + 'px',
					'top': buttons[i].t - 1 + 'px',
					'width': buttons[i].w + 2 + 'px',
					'height': buttons[i].h + 2 + 'px',
					'opacity': .7,
					'z-index': i + 1
				}).addClass('noSel').bind('mouseover.smoothZoom', buttonOver).bind('mouseout.smoothZoom', buttonOut).bind('mousedown.smoothZoom touchstart.smoothZoom', {
					id: i
				}, buttonDown).bind('mouseup.smoothZoom', {
					id: i
				}, buttonUp);

				//Make 2 BGs for Button Normal and Over state
				//Button BG normal
				var tpm = $('<div></div>').appendTo(buttons[i].$ob).attr('id', buttons[i]._var + 'norm').css({
					position: 'absolute',
					left: 1,
					top: 1,
					width: buttons[i].w + 'px',
					height: buttons[i].h + 'px'
				});

				//Button BG hover
				var tpmo = $('<div></div>').appendTo(buttons[i].$ob).attr('id', buttons[i]._var + 'over').css({
					position: 'absolute',
					left: '0px',
					top: '0px',
					width: buttons[i].w + 2 + 'px',
					height: buttons[i].h + 2 + 'px'
				}).hide();

				//Apply corner radius
				if (use_bordRadius || !use_pngTrans || !bu_round) {
					tpm.css('background', bu_color);
					tpmo.css('background', bu_color);
					if (use_bordRadius && bu_round) {
						tpm.css({
							'-moz-border-radius': '2px',
							'-webkit-border-radius': '2px',
							'border-radius': '2px',
							'-khtml-border-radius': '2px'
						});
							tpmo.css({
							'-moz-border-radius': '2px',
							'-webkit-border-radius': '2px',
							'border-radius': '2px',
							'-khtml-border-radius': '2px'
						});
					}
				} else {
					roundBG(tpm, buttons[i]._var + "norm", buttons[i].w, buttons[i].h, 2, 425, bu_color, bu_icon, i + 1, iconOff? 50 : 0);
					roundBG(tpmo, buttons[i]._var + "over", buttons[i].w + 2, buttons[i].h + 2, 2, 425, bu_color, bu_icon, i + 1, iconOff? 50 : 0);
				}

				//Add the button icons
				var cont = $('<div id="' + buttons[i]._var + '_icon"></div>').appendTo(buttons[i].$ob);
				$(cont).css({
					position: 'absolute',
					left: 1,
					top: 1,
					width: buttons[i].w + 'px',
					height: buttons[i].h + 'px',
					'background': 'transparent url(' + bu_icon + ') ' + buttons[i].bx + 'px ' + buttons[i].by + 'px no-repeat'
				});
			}

			//Add Events for mouse drag / touch swipe action
			$(document).bind('mouseup.smoothZoom' + id + ' touchend.smoothZoom' + id, mouseUp);
			if (mouse_drag) {
				$holder.bind('mousedown.smoothZoom touchstart.smoothZoom', mouseDown);
				$holder.bind("touchmove.smoothZoom", mouseDrag);
				$holder.bind("touchend.smoothZoom", mouseUp);
			}

			//Add Double click / Double tap zoom
			if (mouse_dbl_click) {
				$holder.bind('dblclick.smoothZoom', function (e) {
					focusOffX = e.pageX - $holder.offset().left - (sW / 2);
					focusOffY = e.pageY - $holder.offset().top - (sH / 2);
					changeOffset(true,true);
					_wheel = false;
					if (rA < zoom_max && dbl_click_dir == -1 && dClickedX != focusOffX && dClickedY != focusOffY) {
						dbl_click_dir = 1;
					}
					dClickedX = focusOffX;
					dClickedY = focusOffY;

					if (rA >= zoom_max && dbl_click_dir == 1) {
						dbl_click_dir = -1;
					}
					if (rA <= rF && dbl_click_dir == -1) {
						dbl_click_dir = 1;
					}
					if (dbl_click_dir > 0) {
						rA *= 2;
						rA > zoom_max ? rA = zoom_max : "";
						cFlag._zi = true;
						clearTimeout(ani_timer);
						Animate();
						cFlag._zi = false;

					} else {
						rA /= 2;
						rA < rF ? rA = rF : "";
						cFlag._zo = true;
						clearTimeout(ani_timer);
						Animate();
						cFlag._zo = false;
					}

					e.stopPropagation();
					($.browser.msie || e.preventDefault());
				});
			}

			//Add mouse wheel event if enabled
			if (mouse_wheel) $holder.bind('mousewheel.smoothZoom', mouseWheel);

			//Auto Hide the control buttons if enabled
			if (bu_auto) $holder.bind('mouseleave.smoothZoom', autoHide);

			//Prevent Controls Bg from start dragging image
			$controls.bind('mousedown.smoothZoom', function (e) {
				e.stopPropagation();
				($.browser.msie || e.preventDefault());
			});

			//Prevent Controls Bg from double click zoom
			if (mouse_dbl_click) {
				$controls.bind('dblclick.smoothZoom', function (e) {
					e.stopPropagation();
					($.browser.msie || e.preventDefault());
				});
			}

			//Prevent text selection for smoother dragging and button focus
			$('.noSel').each(function () {
				this.onselectstart = function () {
					return false;
				};
			});
		}

		//Control button Events
		var buttonOver = function (e) {
			if ($(this).css('opacity') > .5) $(this).css({
				opacity: 1
			});
		}

		var buttonOut = function (e) {
			if ($(this).css('opacity') > .5) $(this).css({
				opacity: .7
			});
		}

		var buttonDown = function (e) {
			cButtId = e.data.id;
			zDown = true;
			_wheel = false;
			if ($(this).css('opacity') > .5) {
				$holder.find('#' + buttons[cButtId]._var + 'norm').hide();
				$holder.find('#' + buttons[cButtId]._var + 'over').show();
				if (cButtId != 6) {
					cFlag[buttons[cButtId]._var] = true;
				} else {
					cFlag._rs = true;
					rA = rF;
					fX = 0;
					fY = 0;
				}
				focusOffX = focusOffY = 0;
				changeOffset(true,true);
				dbl_click_dir = 1;
				!_playing ? Animate() : "";
			}
			e.stopPropagation();
		}

		var buttonUp = function (e) {
			//This is just for IE. As it skips some mousedown events when clicked quickly, we can compensate it with mouseup
			//Checking !zDown prevents other browsers from double action.
			if (!zDown) {
				cButtId = e.data.id;
				if ($(this).css('opacity') > .5) {
					if (cButtId != 6) {
						cFlag[buttons[cButtId]._var] = true;
					} else {
						cFlag._rs = true;
						rA = rF;
						fX = 0;
						fY = 0;
					}
					focusOffX = focusOffY = 0;
					changeOffset(true,true);
					clearTimeout(ani_timer);
					Animate();
					if (cButtId != 6) cFlag[buttons[cButtId]._var] = false;
				}
			}
		}

		//Image Events for Dragging and Mouse Wheel
		var mouseDown = function (e) {
			//Mouse
			if (e.type == 'mousedown') {
				if (cFlag._nd && _recent != "zoomOut") {
					if ($image.css('-moz-transform') && use_trans2D) correctTransValue();
					offX = e.pageX - $holder.offset().left - $image.position().left;
					offY = e.pageY - $holder.offset().top - $image.position().top;
					drDown = true;
					$(document).bind('mousemove.smoothZoom' + id, mouseDrag);
				}
				e.stopPropagation();
				($.browser.msie || e.preventDefault());

			//Touch
			} else {
				if (cFlag._nd && _recent != "zoomOut") {
					if ($image.css('-moz-transform')) correctTransValue();
					offX = e.originalEvent.changedTouches[0].pageX - $holder.offset().left - $image.position().left;
					offY = e.originalEvent.changedTouches[0].pageY - $holder.offset().top - $image.position().top;
					drDown = true;
				}
				e.preventDefault();
			}
		}

		var mouseDrag = function (e) {
			//Mouse
			if (e.type == 'mousemove') {
				setDraggedPos(e.pageX - $holder.offset().left - offX, e.pageY - $holder.offset().top - offY, _sc);
				_recent = 'drag';
				_dragging = true;
				!_playing ? Animate() : "";
				return false;

			//Touch				
			} else {
				e.preventDefault();
				setDraggedPos(e.originalEvent.changedTouches[0].pageX - $holder.offset().left - offX, e.originalEvent.changedTouches[0].pageY - $holder.offset().top - offY, _sc);
				_recent = 'drag';
				_dragging = true;
				!_playing ? Animate() : "";
			}
		}

		var mouseUp = function (e) {
			if (zDown) {
				$holder.find('#' + buttons[cButtId]._var + 'norm').show();
				$holder.find('#' + buttons[cButtId]._var + 'over').hide();
				if (cButtId !== 6) cFlag[buttons[cButtId]._var] = false;
				zDown = false;
				e.stopPropagation();

			} else if (drDown) {
				if (mouse_drag) {
					//Mouse					
					if (e.type == 'mouseup') {
						$(document).unbind('mousemove.smoothZoom' + id);
						_recent = 'drag';
						_dragging = false;
						!_playing ? Animate() : "";
						drDown = false;

					//Touch
					} else {
						e.preventDefault();
						_recent = 'drag';
						_dragging = false;
						!_playing ? Animate() : "";
						drDown = false;
					}
				}
			}
		}

		if (FF2) {
			$(document).bind('mousemove.smoothZoom' + id + ".mmff2", function (e) {
				mouseX = e.pageX;
				mouseY = e.pageY;
			});
		}
		var mouseWheel = function (e, delta) {
			if (mouse_wheel_cur) {
				if (FF2) {
					focusOffX = mouseX - $holder.offset().left - (sW / 2);
					focusOffY = mouseY - $holder.offset().top - (sH / 2);
				} else {
					focusOffX = e.pageX - $holder.offset().left - (sW / 2);
					focusOffY = e.pageY - $holder.offset().top - (sH / 2);
				}
				changeOffset(true,true);
			}
			_wheel = true;
			_dragging = false;
			if (delta > 0) {
				if (rA != zoom_max) {
					rA *= delta < 1 ? 1 + (.3 * delta) : 1.3;
					rA > zoom_max ? rA = zoom_max : "";
					cFlag._zi = true;
					clearTimeout(ani_timer);
					Animate();
					cFlag._zi = false;
				}
			} else {
				if (rA != rF) {
					rA /= delta > -1 ? 1 + (.3 * -delta) : 1.3;
					rA < rF ? rA = rF : "";
					cFlag._zo = true;
					clearTimeout(ani_timer);
					Animate();
					cFlag._zo = false;
				}
			}
			return false;
		}

		//Control buttons Auto hide
		var autoHide = function (e) {
			clearTimeout(auto_timer);
			auto_timer = setTimeout(function () {
				$controls.fadeOut(600);
			}, bu_delay);

			$holder.bind('mouseenter.smoothZoom', function (e) {
				clearTimeout(auto_timer);
				$controls.fadeIn(300);
			});
		}

		//Mozilla works differently than others when getting translated positions. So this correction needed
		var correctTransValue = function () {
			var v = $image.css('-moz-transform').toString().replace(')', '').split(',');
			transOffX = parseInt(v[4]);
			transOffY = parseInt(v[5]);
		}

		//Make sure the dragged position obeying limits
		var setDraggedPos = function (xp, yp, s) {
			if (xp !== '') {
				dX = xp + transOffX;
				if (pan_limit) {
					dX = dX + (s * iW) < sW ? sW - (s * iW) : dX;
					dX = dX > 0 ? 0 : dX;
					if ((s * iW) < sW) dX = (sW - (s * iW)) / 2;
				} else {
					dX = dX + (s * iW) < sW / 2 ? (sW / 2) - (s * iW) : dX;
					dX = dX > sW / 2 ? sW / 2 : dX;
	
				}
			}
			if (yp !== '') {
				dY = yp + transOffY;
				if (pan_limit) {
					dY = dY + (s * iH) < sH ? sH - (s * iH) : dY;
					dY = dY > 0 ? 0 : dY;
					if ((s * iH) < sH) dY = (sH - (s * iH)) / 2;
				} else {
					dY = dY + (s * iH) < sH / 2 ? (sH / 2) - (s * iH) : dY;
					dY = dY > sH / 2 ? sH / 2 : dY;
				}
			}
		}

		//On windows resize, adjust some defaults
		var windowResize = function () {
			if (String(full_BROWSER_WO).indexOf('%') > -1 ){
				sW = parseInt($('body').innerWidth()*((100-parseInt(full_BROWSER_WO))/100));
			} else {
				sW = $('body').innerWidth() - full_BROWSER_WO;
			}
			if (String(full_BROWSER_HO).indexOf('%') > -1 ){
				sH = parseInt($('body').innerHeight()*((100-parseInt(full_BROWSER_HO))/100));
			} else {
				sH = $('body').innerHeight() - full_BROWSER_HO;
			}
			if (w_max !== 0 && w_max !== '') sW = Math.min(sW, w_max);
			if (h_max !== 0 && h_max !== '') sH = Math.min(sH, h_max);
			$holder.css({
				'width': sW + 'px',
				'height': sH + 'px'
			});
			if (bord_size > 0) {
				border[0].css({
					height: sH + 'px'
				});
				border[1].css({
					height: sH + 'px',
					left: (sW - bord_size) + 'px'
				});
				border[2].css({
					width: sW - (bord_size * 2) + 'px'
				});
				border[3].css({
					width: sW - (bord_size * 2) + 'px',
					top: (sH - bord_size) + 'px'
				});
			}
			checkRatio();
			if (bu_align[1] == 'center') {
				$controls.css('left', parseInt((sW - cBW) / 2) + 'px');
			}
			if (bu_align[0] == 'center') {
				$controls.css('top', parseInt((sH - cBH) / 2) + 'px');
			}
			pan_speed = Math.max(1, ((sW + sH) / 500)) - 1 + (pan_speed_o * pan_speed_o / 4) + 2;
			!_playing ? Animate() : "";
		}

		//Called to animate image transformation whenever the navigation events occur
		var Animate = function () {
			cFlag._nd = true;
			ani_end = false;

			//Zoom In
			if (cFlag._zi) {
				if (!_wheel) rA *= zoom_speed;
				rA > zoom_max ? rA = zoom_max : "";
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'zoomIn';
			}

			//Zoom Out
			if (cFlag._zo) {
				if (!_wheel) rA /= zoom_speed;
				rA < rF ? rA = rF : "";
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'zoomOut';
			}

			//Move Left
			if (cFlag._ml) {
				oX -= pan_speed;
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'left';
			}

			//Move Right
			if (cFlag._mr) {
				oX += pan_speed;
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'right';
			}

			//Move Up
			if (cFlag._mu) {
				oY -= pan_speed;
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'up';
			}

			//Move Down
			if (cFlag._md) {
				oY += pan_speed;
				cFlag._nd = false;
				cFlag._rs = false;
				_recent = 'down';
			}

			//Reset
			if (cFlag._rs) {
				oX += (fX - oX) / 8;
				oY += (fY - oY) / 8;
				cFlag._nd = false;
				_recent = 'reset';
			}

			//Find scale value, width and height
			_sc += (rA - _sc) / ani_smooth;
			_w = _sc * iW;
			_h = _sc * iH;

			//Dragging
			if (_dragging) {
				tX = dX;




				tY = dY;
				changeOffset(true,true);
			}

			//Check if Zoom In completed
			if (_recent == "zoomIn") {
				if (_w > (rA * iW) - pixTol) {
					cFlag._nd ? ani_end = true : "";
					_sc = rA;
					_w = _sc * iW;
					_h = _sc * iH;
				}

				//Check if Zoom Out completed
			} else if (_recent == "zoomOut") {
				if (_w < (rA * iW) + pixTol) {
					cFlag._nd ? ani_end = true : "";
					_sc = rA;
					_w = _sc * iW;
					_h = _sc * iH;
				}

			}

			//Move image according to boundary limits
			limitX = (((_w - sW) / (_w / sW)) / 2);
			limitY = (((_h - sH) / (_h / sH)) / 2);

			if (!_dragging) {
				if (pan_limit) {
					oX < -limitX - focusOffX ? oX = -limitX - focusOffX : "";
					oX > limitX - focusOffX ? oX = limitX - focusOffX : "";
					if (_w<sW) {
						tX = (sW-_w)/2;						
						changeOffset(true,false);
					}
					oY < -limitY - focusOffY ? oY = -limitY - focusOffY : "";
					oY > limitY - focusOffY ? oY = limitY - focusOffY : "";
					if (_h<sH) {
						tY = (sH-_h)/2;			
						changeOffset(false,true);
					}
				} else {
					oX < -limitX - focusOffX - (sW / (_w / sW * 2)) ? oX = -limitX - focusOffX - (sW / (_w / sW * 2)) : "";
					oX > limitX - focusOffX + (sW / (_w / sW * 2)) ? oX = limitX - focusOffX + (sW / (_w / sW * 2)) : "";
					oY < -limitY - focusOffY - (sH / (_h / sH * 2)) ? oY = -limitY - focusOffY - (sH / (_h / sH * 2)) : "";
					oY > limitY - focusOffY + (sH / (_h / sH * 2)) ? oY = limitY - focusOffY + (sH / (_h / sH * 2)) : "";
				}
			}
			if (!_dragging && _recent != "drag") {
				tX = ((sW - _w) / 2) + focusOffX + (oX * (_w / sW));
				tY = ((sH - _h) / 2) + focusOffY + (oY * (_h / sH));
			}
			if (_recent == "zoomIn" || _recent == "zoomOut" || cFlag._rs) {
				_x = tX;
				_y = tY;
			} else {
				_x += (tX - _x) / ani_smooth;
				_y += (tY - _y) / ani_smooth;
			}

			//Check if Left movement completed
			if (_recent == "left") {
				if (_x < tX + pixTol) {
					cFlag._nd ? ani_end = true : "";
					_recent = '';
					_x = tX;
				}

			//Check if Right  movement completed
			} else if (_recent == "right") {
				if (_x > tX - pixTol) {
					cFlag._nd ? ani_end = true : "";
					_recent = '';
					_x = tX;
				}

			//Check if Up movement completed
			} else if (_recent == "up") {
				if (_y < tY + pixTol) {
					cFlag._nd ? ani_end = true : "";
					_recent = '';
					_y = tY;
				}

			//Check if Down movement completed
			} else if (_recent == "down") {
				if (_y > tY - pixTol) {
					cFlag._nd ? ani_end = true : "";
					_recent = '';
					_y = tY;
				}

			//Check if Dragging completed
			} else if (_recent == "drag") {
				if (_x + pixTol >= tX && _x - pixTol <= tX && _y + pixTol >= tY && _y - pixTol <= tY) {
					if (_onfocus) _dragging = false;
					cFlag._nd ? ani_end = true : "";
					_recent = '';
					_x = tX;
					_y = tY;
				}
			}

			//Check if Reset completed
			if (cFlag._rs) {
				if (_w + pixTol >= (rA * iW) && _w - pixTol <= (rA * iW) && _x == tX && _y == tY && oX < pixTol && oX > -pixTol && oY < pixTol && oY > -pixTol) {
					ani_end = true;
					_recent = '';
					cFlag._rs = false;
					cFlag._nd = true;
					_x = tX;
					_y = tY;
					_sc = rA;
					_w = _sc * iW;
					_h = _sc * iH;
				}
			}

			//When the image fits exactly to container size, disable the pan, zoom out and rest buttons
			if (rA == rF) {
				if (buttons[1].$ob.css('opacity') > .5) {
					if (rA >= rF) {
						if (pan_limit && mouse_drag && !_moveCursor) $image.css('cursor', 'default'), $hitArea.css('cursor', 'default');
						for (var bEn = 1; bEn < (pan_limit && !_moveCursor ? buttons_total : 2); bEn++) {
							buttons[bEn].$ob.css({
								'opacity': .4
							});
							$holder.find('#' + buttons[bEn]._var + 'norm').show();
							$holder.find('#' + buttons[bEn]._var + 'over').hide();
						}
					}
				}

			} else {
				if (buttons[1].$ob.css('opacity') < .5) {
					if (mouse_drag) $image.css('cursor', 'move'), $hitArea.css('cursor', 'move');
					for (var bEn = 1; bEn < buttons_total; bEn++) buttons[bEn].$ob.css({
						'opacity': .7
					});
				}
			}

			//When the image reaches max zoom, disable the zoom button
			if (rA == zoom_max) {
				if (buttons[0].$ob.css('opacity') > .5) {
					buttons[0].$ob.css({
						'opacity': .4
					});
					$holder.find('#' + buttons[0]._var + 'norm').show();
					$holder.find('#' + buttons[0]._var + 'over').hide();
				}

			} else {
				if (buttons[0].$ob.css('opacity') < .5) buttons[0].$ob.css({
					'opacity': .7
				})
			}

			//Apply Scale and position to the image:
			//1. If the browser suppports css 3D transformation, go this way (For best performance enabling hardware acceleration)		
			if (use_trans3D) {
				$image.css(prop_origin, 'left top');
				$image.css(prop_transform, 'translate3d(' + _x + 'px,' + _y + 'px,0) scale(' + _sc + ')');

			//2. If the browser suppports only 2D transformation, go this way	
			} else if (use_trans2D) {
				$image.css(prop_origin, 'left top');
				$image.css(prop_transform, 'translate(' + _x + 'px,' + _y + 'px) scale(' + _sc + ')');

			//3. Sadly for older browsers, stick with usual css properties
			} else {
				$image.css({
					width: _w,
					height: _h,
					left: _x + 'px',
					top: _y + 'px'
				});
			}

			//In case image Maps used, update them
			if (!use_trans2D && !use_trans3D) {
				map_coordinates.length > 0 ? updateMap() : "";
			}

			//If the animation completed, stop running; else continue	
			if (ani_end && _playing && !_dragging && _recent != "drag") {
				_playing = false;
				_recent = '';
				clearTimeout(ani_timer);
			} else {
				_playing = true;
				ani_timer = setTimeout(Animate, 28);					
			}
		}


		//If the broswer doesn't supports css border radius, we need to go with old school png image for rounded corner
		var roundBG = function (el, _name, _w, _h, _r, _p, _c, _i, _z, _yoff) {
			var w = 50 / 2;
			//Top-Left, Top-Center, Top-Right:
			$('<div class="bgi' + _name + '" style="background-position:' + (-(_p - _r)) + 'px ' + (-(w - _r)-_yoff) + 'px"></div>').appendTo(el);
			$('<div class="bgh' + _name + '"></div>').appendTo(el);
			$('<div class="bgi' + _name + '" style="background-position:' + (-_p) + 'px ' + (-(w - _r)-_yoff) + 'px; left:' + (_w - _r) + 'px"></div>').appendTo(el);

			//Bottom-Left, Bottom-Center, Bottom-Right:
			$('<div class="bgi' + _name + '" style="background-position:' + (-(_p - _r)) + 'px ' + (-w-_yoff) + 'px; top:' + (_h - _r) + 'px"></div>').appendTo(el);
			$('<div class="bgh' + _name + '" style = "top:' + (_h - _r) + 'px; left:' + _r + 'px"></div>').appendTo(el);
			$('<div class="bgi' + _name + '" style="background-position:' + (-_p) + 'px ' + (-w-_yoff) + 'px; top:' + (_h - _r) + 'px; left:' + (_w - _r) + 'px"></div>').appendTo(el);

			//Middle Center'\
			$('<div class="bgc' + _name + '"></div>').appendTo(el);

			$('.bgi' + _name).css({
				position: 'absolute',
				width: _r + 'px',
				height: _r + 'px',
				'background-image': 'url(' + _i + ')',
				'background-repeat': 'no-repeat',
				'-ms-filter': 'progid:DXImageTransform.Microsoft.gradient(startColorstr=#00FFFFFF,endColorstr=#00FFFFFF)',
				'filter': 'progid:DXImageTransform.Microsoft.gradient(startColorstr=#00FFFFFF,endColorstr=#00FFFFFF)',
				'zoom': 1
			});
			$('.bgh' + _name).css({
				position: 'absolute',
				width: _w - _r * 2,
				height: _r + 'px',
				'background-color': _c,
				left: _r
			});
			$('.bgc' + _name).css({
				position: 'absolute',
				width: _w,
				height: _h - _r * 2,
				'background-color': _c,
				top: _r,
				left: 0
			});
		}

		var changeOffset = function (x,y) {
			x ? oX = (tX - ((sW - _w) / 2) - focusOffX) / (_w / sW) : "";
			y ? oY = (tY - ((sH - _h) / 2) - focusOffY) / (_h / sH) : "";
		}

		//Transform Image Maps (hot spots) if any
		var updateMap = function () {
			var mapId = 0;
			mapAreas.each(function () {
				var new_vals = [];
				for (var i = 0; i < map_coordinates[mapId].length; i++) {
					new_vals[i] = map_coordinates[mapId][i] * _sc;
				}
				new_vals = new_vals.join(",");

				$(this).attr('coords', new_vals);
				mapId++;
			});
		}

		//To stop the timer loops immediatly
		var haltAnimation = function () {
			clearTimeout(ani_timer);
			_playing = false;
			_recent = '';
		}

		//Method to Remove the plugin instance
		this.destroy = function () {
			if (_mainLoaded && _iconLoaded) {
				haltAnimation();
				for (prop in orig_style) {
					if (orig_style[prop][0] !== false && orig_style[prop][0] !== undefined) {
						if (orig_style[prop][0] === 'width' || orig_style[prop][0] === 'height') {
							if (parseInt(orig_style[prop][1]) !== 0) $image.css(orig_style[prop][0], orig_style[prop][1]);
						} else {
							$image.css(orig_style[prop][0], orig_style[prop][1]);
						}
					}
				}
				clearTimeout(auto_timer);
				$(document).unbind('.smoothZoom' + id);
				$(window).unbind('.smoothZoom' + id);
				$controls = undefined;
			} else {
				$image.show();
			} 
			$image.unbind('load');
			$(icons).unbind('load.smoothZoom onreadystatechange.smoothZoom');
			$image.insertBefore($holder);				
			$holder !== undefined ? $holder.remove() : "";
			$image.removeData('smoothZoom');
			$holder = undefined;
			Buttons = undefined;
			op = undefined;
			$image = undefined;
				
		}

		//Method to change focus point and level
		this.focusTo = function (params) {			
			if (_mainLoaded && _iconLoaded) {
				if (params.zoom === undefined || params.zoom === '' || params.zoom == 0) {				
					params.zoom = rA;
				} else {
					params.zoom /= 100;
				}			
				_onfocus = true;
				if (params.zoom > rA && rA != zoom_max) {
					rA = params.zoom;
					rA > zoom_max ? rA = zoom_max : "";
				} else if (params.zoom < rA && rA != rF) {
					rA = params.zoom;
					rA < rF ? rA = rF : "";
				}
				setDraggedPos(params.x === undefined || params.x === ''? "" : (-params.x * rA) + (sW / 2), params.y === undefined || params.y === ''? "" : (-params.y * rA) + (sH / 2) , rA);
				_recent = 'drag';
				_dragging = true;
				clearTimeout(ani_timer);
				Animate();
			}
		}
		
		this.zoomIn = function (params) {	
			buttons[0].$ob.trigger('mousedown.smoothZoom', {id:0});				
		}
		this.zoomOut = function (params) {	
			buttons[1].$ob.trigger('mousedown.smoothZoom', {id:1});				
		}		
		this.moveRight = function (params) {	
			buttons[2].$ob.trigger('mousedown.smoothZoom', {id:2});				
		}
		this.moveLeft = function (params) {	
			buttons[3].$ob.trigger('mousedown.smoothZoom', {id:3});				
		}
		this.moveUp = function (params) {	
			buttons[4].$ob.trigger('mousedown.smoothZoom', {id:4});				
		}
		this.moveDown = function (params) {	
			buttons[5].$ob.trigger('mousedown.smoothZoom', {id:5});				
		}
		this.Reset = function (params) {	
			buttons[6].$ob.trigger('mousedown.smoothZoom', {id:6});				
		}
		this.getZoomData = function (params) {
			return {
				normX: 		-_x/rA,		//x offset (without scale ratio multiplied)
				normY: 		-_y/rA,		//y offset (without scale ratio multiplied)
				normWidth: 	iW,			//Original image Width
				normHeight:	iH,			//Original image height
				
				scaledX: 		-_x,	//x offset (with scale ratio multiplied)
				scaledY: 		-_y,	//y offset (with scale ratio multiplied)
				scaledWidth: 	_w,		//Scaled image width
				scaledHeight: 	_h,		//Scaled image height			
				
				centerX: 	(-parseInt(_x)+(sW/2))/rA,	//The X location on image which is currently on center of canvas 
				centerY: 	(-parseInt(_y)+(sH/2))/rA,	//The Y location on image which is currently on center of canvas 
				
				ratio: 		rA			//Scale ratio

			};
		}		
		init();
	}

	//Preloader loop class
	function setLoadingLoop(_holder) {
		var _currentX = 0;
		var _spriteW = 24;
		var _timer = "";
		var _ob = $('<div></div>');
		var _bg = $('<div></div>');
		_ob.appendTo(_holder).css({
			position: 'absolute',
			width: _spriteW + 'px',
			height: _spriteW + 'px',
			top: '50%',
			left: '50%',
			'z-index': 1
		});
		_bg.appendTo(_ob).css({
			position: 'absolute',
			width: _spriteW + 'px',
			height: _spriteW + 'px',
			top: -_spriteW / 2 + 'px',
			left: -_spriteW / 2 + 'px',
			'background': 'url(http://itp.nyu.edu/~mae383/sinatra/final/public/zoom_assets/preloader.png)'
		});
		_timer = setInterval(function () {
			_currentX -= _spriteW;
			_currentX < 0 ? _currentX = _spriteW * 14 : "";
			_bg.css({
				'background-position': _currentX + 'px 0px'
			});
		}, 36);
		this.destroy = function () {
			clearInterval(_timer);
			_ob.remove();
		}
		return this;
	}

	$.fn.smoothZoom = function (params) {
		var args = arguments;
		var $image;
		var instance;
		
		//Case 1: 
		//Take care if multiple instances called (probably initiated using class). With this way, it is not possible to get return value by getZoomData() method
		if (this.length>1){
			return this.each(function () {
				$image = $(this);
				instance = $image.data('smoothZoom');
				if (!instance) {
					
					//Initiate the plugin
					if (typeof params === 'object' || !params){
						$image.data('smoothZoom',  new zoomer($image, params));	
					}
				} else {
					
					/*Calling one of the following methods: 
						1. destroy() 				- Returns nothing
						2. focusTo({x, y, zoom})	- Returns nothing
					*/
					if (instance[params]) {					
						instance[params].apply(this, Array.prototype.slice.call(args, 1));
					}
				}
			});
		
		//Case 2:
		//Single instance. This will support
		} else {
			$image = $(this);
			instance = $image.data('smoothZoom');
			if (!instance) {
				
				//Initiate the plugin
				if (typeof params === 'object' || !params){
					return $image.data('smoothZoom',  new zoomer($image, params));	
				}
			} else {
				
				/*Calling one of the following methods: 
					1. destroy()				- Returns nothing
					2. focusTo({x, y, zoom})	- Returns nothing
					3. getZoomData				- Returns {sourceX, sourceY, sourceWidth, sourceHeight, distX, distY, distWidth, distHeight, ratio, centerX, centerY}
				*/
				if (instance[params]) {					
					return instance[params].apply(this, Array.prototype.slice.call(args, 1));
				}
			}
		}
	};
})(jQuery);

//...................................................................................................................
//Use Modernizr, to check browser capabilities and get browser specific property names

	/* Modernizr 2.0.6 (Custom Build) | MIT & BSD
	 * Contains: borderradius | csstransforms | csstransforms3d | touch | prefixed | teststyles | testprop | testallprops | hasevent | prefixes | domprefixes
	 */
	var Modernizr=function(a,b,c){function C(a,b){var c=a.charAt(0).toUpperCase()+a.substr(1),d=(a+" "+n.join(c+" ")+c).split(" ");return B(d,b)}function B(a,b){for(var d in a)if(j[a[d]]!==c)return b=="pfx"?a[d]:!0;return!1}function A(a,b){return!!~(""+a).indexOf(b)}function z(a,b){return typeof a===b}function y(a,b){return x(m.join(a+";")+(b||""))}function x(a){j.cssText=a}var d="2.0.6",e={},f=b.documentElement,g=b.head||b.getElementsByTagName("head")[0],h="modernizr",i=b.createElement(h),j=i.style,k,l=Object.prototype.toString,m=" -webkit- -moz- -o- -ms- -khtml- ".split(" "),n="Webkit Moz O ms Khtml".split(" "),o={},p={},q={},r=[],s=function(a,c,d,e){var g,i,j,k=b.createElement("div");if(parseInt(d,10))while(d--)j=b.createElement("div"),j.id=e?e[d]:h+(d+1),k.appendChild(j);g=["&shy;","<style>",a,"</style>"].join(""),k.id=h,k.innerHTML+=g,f.appendChild(k),i=c(k,a),k.parentNode.removeChild(k);return!!i},t=function(){function d(d,e){e=e||b.createElement(a[d]||"div"),d="on"+d;var f=d in e;f||(e.setAttribute||(e=b.createElement("div")),e.setAttribute&&e.removeAttribute&&(e.setAttribute(d,""),f=z(e[d],"function"),z(e[d],c)||(e[d]=c),e.removeAttribute(d))),e=null;return f}var a={select:"input",change:"input",submit:"form",reset:"form",error:"img",load:"img",abort:"img"};return d}(),u,v={}.hasOwnProperty,w;!z(v,c)&&!z(v.call,c)?w=function(a,b){return v.call(a,b)}:w=function(a,b){return b in a&&z(a.constructor.prototype[b],c)};var D=function(c,d){var f=c.join(""),g=d.length;s(f,function(c,d){var f=b.styleSheets[b.styleSheets.length-1],h=f.cssRules&&f.cssRules[0]?f.cssRules[0].cssText:f.cssText||"",i=c.childNodes,j={};while(g--)j[i[g].id]=i[g];e.touch="ontouchstart"in a||j.touch.offsetTop===9,e.csstransforms3d=j.csstransforms3d.offsetLeft===9},g,d)}([,["@media (",m.join("touch-enabled),("),h,")","{#touch{top:9px;position:absolute}}"].join(""),["@media (",m.join("transform-3d),("),h,")","{#csstransforms3d{left:9px;position:absolute}}"].join("")],[,"touch","csstransforms3d"]);o.touch=function(){return e.touch},o.borderradius=function(){return C("borderRadius")},o.csstransforms=function(){return!!B(["transformProperty","WebkitTransform","MozTransform","OTransform","msTransform"])},o.csstransforms3d=function(){var a=!!B(["perspectiveProperty","WebkitPerspective","MozPerspective","OPerspective","msPerspective"]);a&&"webkitPerspective"in f.style&&(a=e.csstransforms3d);return a};for(var E in o)w(o,E)&&(u=E.toLowerCase(),e[u]=o[E](),r.push((e[u]?"":"no-")+u));x(""),i=k=null,e._version=d,e._prefixes=m,e._domPrefixes=n,e.hasEvent=t,e.testProp=function(a){return B([a])},e.testAllProps=C,e.testStyles=s,e.prefixed=function(a){return C(a,"pfx")};return e}(this,this.document);

//Old Browsers need special attention
var FF2 = $.browser.mozilla && (parseFloat($.browser.version) < 1.9) ? true : false;
var IE6 = $.browser.msie && parseInt($.browser.version, 10) <=6 ? true : false;

var prop_transform = Modernizr.prefixed('transform');
var prop_origin = Modernizr.prefixed('transformOrigin');
var use_trans2D = Modernizr.csstransforms && prop_transform !== false && prop_origin !== false && !$.browser.mozilla ? true : false;
var use_trans3D = Modernizr.csstransforms3d && prop_transform !== false && prop_origin !== false ? true : false;
var use_bordRadius = $.browser.mozilla && FF2 ? false : Modernizr.borderradius;
var use_pngTrans = IE6 ? false : true;

//For mouse wheel support
	
	/* Copyright (c) 2009 Brandon Aaron (http://brandonaaron.net)
	 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
	 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
	 * Thanks to: http://adomas.org/javascript-mouse-wheel/ for some pointers.
	 * Thanks to: Mathias Bank(http://www.mathias-bank.de) for a scope bug fix.
	 *
	 * Version: 3.0.2
	 * 
	 * Requires: 1.2.2+
	 */
(function(c){var a=["DOMMouseScroll","mousewheel"];c.event.special.mousewheel={setup:function(){if(this.addEventListener){for(var d=a.length;d;){this.addEventListener(a[--d],b,false)}}else{this.onmousewheel=b}},teardown:function(){if(this.removeEventListener){for(var d=a.length;d;){this.removeEventListener(a[--d],b,false)}}else{this.onmousewheel=null}}};c.fn.extend({mousewheel:function(d){return d?this.bind("mousewheel",d):this.trigger("mousewheel")},unmousewheel:function(d){return this.unbind("mousewheel",d)}});function b(f){var d=[].slice.call(arguments,1),g=0,e=true;f=c.event.fix(f||window.event);f.type="mousewheel";if(f.wheelDelta){g=f.wheelDelta/120}if(f.detail){g=-f.detail/3}d.unshift(f,g);return c.event.handle.apply(this,d)}})(jQuery);
//...................................................................................................................