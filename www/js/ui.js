/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="../lib/jquery.autocomplete/jquery.autocomplete.d.ts" />
/// <reference path="../lib/googlemaps/google.maps.d.ts" />
/// <reference path="../lib/FileManager.d.ts" />
/// <reference path="../lib/async_loader.d.ts" />
var UI;
(function (UI) {
    var Controll = (function () {
        function Controll() {
        }
        Controll.init = function (root) {
            var $root = $(root);
            $.each(UI, function (name, cls) {
                if (name == 'Controll') {
                    return;
                }

                try  {
                    cls.check();
                    Controll.load(name);
                } catch (e) {
                    console.log('loading: ', name, e);
                    //throw e;
                }
            });
        };
        Controll.load = function (name) {
            var cls = UI[name];
            cls.check();
            var $root = $(document.body);
            var items = $root.find('[qtype="' + name + '"]');
            $.each(items, function (i, item) {
                var obj = new cls(item);
                Controll.registry.push(obj);
                $(item).attr('ui-id', Controll.registry.lastIndexOf(obj));
            });
            console.log('loading: ', name, items.length);
        };
        Controll.registry = [];
        Controll.services = [];
        return Controll;
    })();
    UI.Controll = Controll;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="../lib/jquery.autocomplete/jquery.autocomplete.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var AddressFilter = (function () {
        function AddressFilter(input) {
            var _this = this;
            this.variants = function () {
                var r = {
                    input: _this.input.val(),
                    types: ['(regions)']
                };
                AddressFilter.getAutofill().getPlacePredictions(r, function (results, status) {
                    _this.result = [];
                    $.each(results, function (k, v) {
                        _this.result.push(v.description);
                    });
                    _this.input.data('autocomplete').display(_this.result, false);
                });
                return _this.result;
            };
            this.input = $(input);
            window['loader'].on('autocomplete', function () {
                _this.input.autocomplete({
                    source: _this.variants,
                    prefix: false,
                    delay: 1,
                    minLength: 3,
                    match: false
                });
            });
        }
        AddressFilter.check = function () {
            if (typeof (google) != 'undefined' && typeof (google.maps) != 'undefined') {
                return true;
            }
            window['loader'].on('google_maps', function () {
                UI.Controll.load('AddressFilter');
                console.log('loading');
            });
            return true;
        };

        AddressFilter.getAutofill = function () {
            if (!AddressFilter.autofill)
                AddressFilter.autofill = new google.maps.places.AutocompleteService;
            return AddressFilter.autofill;
        };
        return AddressFilter;
    })();
    UI.AddressFilter = AddressFilter;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var confirm = (function () {
        function confirm(item) {
            var _this = this;
            this.url = $(item).attr('href');
            this.text = $(item).attr('data-text');
            $(item).attr('href', null).attr('data-text', null).click(function (e) {
                var current = $(e.currentTarget);
                e.preventDefault();
                if (window.confirm(_this.text ? _this.text : 'Confirm action?'))
                    location.href = _this.url;
            });
        }
        confirm.check = function () {
            return true;
        };
        return confirm;
    })();
    UI.confirm = confirm;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Content = (function () {
        function Content(item) {
            var _this = this;
            this.save = function (e) {
                console.log(window['e'] = e);
                if (_this.node.attr('data-type') == 'part') {
                    var id = parseInt(_this.node.attr('data-id'));
                    var name = _this.node.attr('data-part');
                    if (['text', 'title'].indexOf(name) == -1)
                        return console.log('Unsupported data-part attribute: ' + name);
                    var data = {
                        'id': id
                    };
                    data[name] = name == 'text' ? e.getContent() : $(e.targetElm).text();
                    $.ajax({
                        url: '/!Page/part.json',
                        data: data,
                        method: 'POST',
                        success: function (data) {
                            if (window['infobox'])
                                window['infobox'].add('Successfuly saved!', { type: 'success' });
                        },
                        error: function (jx, status, text) {
                            if (window['infobox'])
                                window['infobox'].add('Save failed. ' + status + '! ' + text, { type: 'alert' });
                            console.log('save failed!');
                        }
                    });
                } else
                    console.log('Unsupported data-type attribute: ' + _this.node.attr('data-type'));

                window['editor'] = e;
            };
            this.change = function (e) {
                if (!_this.editor) {
                    _this.editor = e;
                    UI.Unload.add(_this.unload);
                }
            };
            this.unload = function () {
                if (_this.editor.getContent() != _this.editor.start_content)
                    return 'Page contains unsaved changes!';
            };
            this.node = $(item);
            this.init_controll();
        }
        Content.prototype.init_controll = function () {
            if (!Content.controll) {
                Content.controll = document.createElement('label');
                Content.controll.setAttribute('id', 'content_editable');
                var input = document.createElement('input');
                var span = document.createElement('span');
                span.textContent = 'Editable';
                input.setAttribute('type', 'checkbox');
                Content.controll.appendChild(input);
                Content.controll.appendChild(span);
                document.body.appendChild(Content.controll);
                $(Content.controll).change(function () {
                    var val = $(input).is(':checked');
                    for (var i = 0; i < UI.Controll.registry.length; i++) {
                        if (UI.Controll.registry[i] instanceof Content) {
                            UI.Controll.registry[i].enable(val);
                        }
                    }
                });
            }
        };

        Content.prototype.init = function () {
            var _this = this;
            var config = {};
            for (var it in UI.Html.config)
                config[it] = UI.Html.config[it];
            config.inline = true;
            config.save_onsavecallback = this.save;
            config.setup = function (editor) {
                editor.on('change', _this.change);
            };
            if (this.node.attr('data-part') != 'text') {
                config.toolbar = 'save | undo redo';
                config.menubar = false;
                config.forced_root_block = false;
                config.plugins = ['save'];
                delete config.toolbar1;
                delete config.toolbar2;
            }
            this.tinymce = this.node.tinymce(config);
        };

        Content.prototype.enable = function (enabled) {
            if (typeof enabled === "undefined") { enabled = true; }
            this.node.attr('contenteditable', enabled);
            if (enabled && !this.tinymce)
                this.init();
        };

        Content.check = function () {
            if (typeof ($.fn.tinymce) == 'undefined') {
                loader.on('tinymce', function () {
                    //if not loaded, init after tinymce load
                    UI.Controll.load('Html');
                });
                throw 'TinyMCE not loaded, yet?';
            }
        };
        return Content;
    })();
    UI.Content = Content;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Html = (function () {
        function Html(item) {
            var $item = $(item);
            this.tinymce = $item.tinymce(Html.config);
        }
        Html.check = function () {
            if (typeof ($.fn.tinymce) == 'undefined') {
                loader.on('tinymce', function () {
                    //if not loaded, init after tinymce load
                    UI.Controll.load('Html');
                });
                throw 'TinyMCE not loaded, yet?';
            }
        };
        Html.config = {
            plugins: [
                "autolink lists link image anchor",
                "searchreplace visualblocks code fullscreen",
                "save media table contextmenu paste"
            ],
            schema: "html5",
            relative_urls: false,
            file_browser_callback: function (id, value, type, win) {
                var fm = new FileManager.FileManager;
                $(fm).one('close', function (e, result) {
                    var img = result.files.pop();
                    jQuery('#' + id).val(img.getFullUrl());
                });
                fm.open();
            },
            toolbar1: "undo redo |  save | styleselect  | outdent indent | bullist numlist",
            toolbar2: "bold italic | alignleft aligncenter alignright alignjustify | forecolor backcolor  | link image",
            formats: {
                alignleft: { selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'left' },
                aligncenter: { selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'center' },
                alignright: { selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table', classes: 'right' },
                alignjustify: { selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table', classes: 'justify' }
            },
            height: 680
        };
        return Html;
    })();
    UI.Html = Html;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var ImageInput = (function () {
        function ImageInput(item) {
            var _this = this;
            this.onClose = function (e, files) {
                var file = files.files.pop();
                var root = _this.fm.root;
                if (root.substr(-1) == '/')
                    root = root.substr(0, root.length - 1);
                var path = file.path;
                if (path.substr(-1) == '/')
                    path = path.substr(0, path.length - 1);
                var link = root + file.path + '/' + file.name;
                _this.input.val(link);
                _this.image.attr('src', '/img/thumbup.128' + link).attr('alt', file.name);
                _this.fm = null;
                //this.root.on('click tap', this.openfm);
            };
            this.openfm = function () {
                _this.fm = new FileManager.FileManager;
                $(_this.fm).on('close', _this.onClose);
                _this.fm.open({ cwd: _this.root_dir });
            };
            this.root = $(item);
            this.input = this.root.find('input');
            this.image = this.root.find('img');
            this.root_dir = this.root.attr('data-path');
            this.root.attr('data-path', null);

            this.root.on('click tap', function (e) {
                e.preventDefault();
                _this.openfm();
            });
        }
        ImageInput.check = function () {
            if (typeof FileManager == 'undefined')
                throw 'FileManager not loaded.';
        };
        return ImageInput;
    })();
    UI.ImageInput = ImageInput;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="../lib/FileManager.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var ImagesListInput = (function () {
        function ImagesListInput(item) {
            var _this = this;
            this.inc = 0;
            this.onClose = function (e, files) {
                //for each selected file add image and hidden input
                $.each(files.files, function (it, image) {
                    var id = _this.inc++;
                    var div = $('<span/>', { 'qtype': 'Image', 'qId': id });
                    var img = $('<img>', {
                        'src': image.getPreview(128)
                    });
                    var input = $('<input />').attr({
                        'type': 'hidden',
                        'name': _this.root.attr('name') + '[a' + id + ']',
                        'value': image.getFullUrl()
                    });
                    _this.img_list.append(div.append(img).append(input));
                    if (!_this.preview.val())
                        _this.preview.val('a' + id);
                });
            };
            this.onMouseIn = function (e) {
                var current = $(e.currentTarget);
                var remove = $('<a />').attr({
                    'href': '#remove',
                    'title': 'remove',
                    'class': 'remove'
                }).click(function (e) {
                    var current = $(e.currentTarget);
                    e.preventDefault();
                    _this.preview.val(false);
                    current.parent().remove();
                });
                var select = $('<a />').attr({
                    'href': '#select',
                    'title': 'select',
                    'class': 'select'
                }).click(function (e) {
                    var current = $(e.currentTarget);
                    e.preventDefault();
                    _this.preview.val(current.parent().attr('qId'));
                    current.parent().addClass('current').siblings().removeClass('current');
                });
                current.append(remove).append(select);
            };
            this.onMouseOut = function (e) {
                var current = $(e.currentTarget);
                current.find('a').remove();
            };
            this.root = $(item);
            this.button = this.root.find('[qtype="ImagesListAdd"]');
            this.img_list = this.root.find('[qtype="ImagesList"]');
            this.preview = this.root.find('[qtype="PreviewImage"]');
            this.button.click(function (e, files) {
                e.preventDefault();
                var fm = new FileManager.FileManager;
                $(fm).one('close', _this.onClose);
                fm.open();
            });
            this.img_list.on('mouseenter', '[qtype=Image]', this.onMouseIn).on('mouseleave', '[qtype=Image]', this.onMouseOut);
        }
        ImagesListInput.check = function () {
            if (typeof (FileManager) == 'undefined') {
                window['loader'].on('filemanager', function () {
                    UI.Controll.load('ImagesListInput');
                });
                throw 'FileManager not loaded, yet?';
            }
        };
        return ImagesListInput;
    })();
    UI.ImagesListInput = ImagesListInput;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="../lib/googlemaps/google.maps.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var MapInputPoint = (function () {
        function MapInputPoint(item) {
            var _this = this;
            this.mapClick = function (e) {
                //console.log('click', e.latLng);
                if (_this.marker)
                    _this.marker.setPosition(e.latLng);
                else
                    _this.markerCreate(e.latLng);
                _this.update();
            };
            this.root = $(item);

            //inputs
            this.lat = this.root.find('input[data-name="lat"]');
            this.lng = this.root.find('input[data-name="lng"]');
            this.loc = this.root.find('input[data-name="loc"]');
            this.map = new google.maps.Map(this.root.find('[qtype="MapField"]')[0], {
                zoom: 5,
                center: (this.lat.val() !== '') ? new google.maps.LatLng(this.lat.val(), this.lng.val()) : new google.maps.LatLng(48.491719684751274, 32.147674890625034),
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                mapTypeControl: false,
                rotateControl: false,
                streetViewControl: false
            });
            if (this.lat.val() !== '') {
                this.markerCreate(new google.maps.LatLng(this.lat.val(), this.lng.val()));
            }
            this.map.addListener('click', this.mapClick);

            this.root.find('[qtype="IconFind"]').click(function () {
                console.log('click', _this.loc, _this.loc.val());
                if (_this.loc.val().length > 3)
                    MapInputPoint.getGeocoder().geocode({ 'address': _this.loc.val() }, function (results, status) {
                        if (results != null) {
                            _this.lat.val(results[0].geometry.location.lat());
                            _this.lng.val(results[0].geometry.location.lng());
                            _this.loc.val(results[0].formatted_address);
                            var address = {};
                            $.each(results[0].address_components, function (k, v) {
                                $.each(v.types, function (t, type) {
                                    address[type] = v.long_name;
                                });
                            });
                            console.log(address);
                            if (_this.marker)
                                _this.marker.setPosition(results[0].geometry.location);
                            else
                                _this.markerCreate(results[0].geometry.location);
                        }
                    });
            });
        }
        MapInputPoint.getGeocoder = function () {
            if (!MapInputPoint.geocoder)
                MapInputPoint.geocoder = new google.maps.Geocoder();
            return MapInputPoint.geocoder;
        };

        MapInputPoint.prototype.markerCreate = function (location) {
            var _this = this;
            if (this.marker)
                this.marker.setMap(null);
            this.marker = new google.maps.Marker({
                map: this.map,
                position: location,
                draggable: true
            });

            this.marker.addListener('dragend', function (e) {
                _this.update();
            });
        };

        MapInputPoint.prototype.update = function () {
            var _this = this;
            if (this.lat.val() != this.marker.getPosition().lat() || this.lng.val() != this.marker.getPosition().lng()) {
                this.lat.val(this.marker.getPosition().lat());
                this.lng.val(this.marker.getPosition().lng());
                MapInputPoint.getGeocoder().geocode({ 'latLng': this.marker.getPosition() }, function (results, status) {
                    if (results != null)
                        _this.loc.val(results[0].formatted_address);
                    //    console.log(results,status);
                });
            }
        };

        MapInputPoint.check = function () {
            if (typeof (google.maps) != 'undefined')
                return true;
            window['loader'].on('google_maps', function () {
                //                UI.Controll.addService('maps.geocoder', MapInputPoint.getGeocoder);
                UI.Controll.load('MapInputPoint');
            });
        };
        MapInputPoint.geocoder = null;
        return MapInputPoint;
    })();
    UI.MapInputPoint = MapInputPoint;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var MLSelect = (function () {
        function MLSelect(item) {
            var _this = this;
            this.onChange = function (e) {
                var current = $(e.currentTarget);
                var level = parseInt(current.attr('data-level'));
                current.nextAll('select').remove();
                if ((typeof _this.data[level] != "undefined") && (typeof _this.data[level][current.val()] != "undefined")) {
                    var options = {
                        'name': current.attr('name'),
                        'data-level': level + 1
                    };
                    options.name = options.name.substr(0, options.name.lastIndexOf('[')) + '[' + (level + 1) + ']';
                    if (_this.root.attr('required'))
                        options.required = true;

                    var input = $('<select/>', options);
                    input.append('<option value="" selected' + (_this.root.attr('required') ? ' disabled' : '') + '></option>');
                    $.each(_this.data[level + 1][current.val()], function (val, text) {
                        input.append('<option value="' + val + '">' + text + '</option>');
                    });
                    current.after(input);
                }
            };
            this.root = $(item);
            this.data = JSON.parse(this.root.attr('data-values'));
            this.root.attr('data-values', null);
            this.root.on('change', 'select', this.onChange);
        }
        MLSelect.check = function () {
            return true;
        };
        return MLSelect;
    })();
    UI.MLSelect = MLSelect;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Poll = (function () {
        function Poll(item) {
            var _this = this;
            this.onVote = function (e) {
                $.post('/!Poll', {
                    id: _this.root.attr('widget'),
                    vote: _this.root.find('input:checked').val()
                }, function (data) {
                    _this.root = _this.root.replaceWith(data);
                });
            };
            this.root = $(item);
            var button = this.root.find('[qtype="button"]');
            if (!button.attr('disabled'))
                button.click(this.onVote);
        }
        Poll.check = function () {
            return true;
        };
        return Poll;
    })();
    UI.Poll = Poll;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Range = (function () {
        function Range(item) {
            this.$item = $(item);
            var value = this.$item.val().split(';');
            console.log(value);
            var options = {
                type: "double",
                from: (typeof (value[0]) != 'undefined') ? value[0] : 0,
                to: (typeof (value[1]) != 'undefined') ? value[1] : (this.$item.attr('max') ? this.$item.attr('max') : 1),
                min: (this.$item.attr('min') ? this.$item.attr('min') : 0),
                max: (this.$item.attr('max') ? this.$item.attr('max') : 1),
                step: (this.$item.attr('step') ? this.$item.attr('step') : 1),
                values: (this.$item.attr('values') ? this.$item.attr('values').split(',') : null)
            };
            this.$item.ionRangeSlider(options);
        }
        Range.check = function () {
            if (typeof ($.fn.ionRangeSlider) == 'function')
                return true;
            window['loader'].on('range', function () {
                UI.Controll.load('Range');
            });
            throw 'waiting for other js file';
        };
        return Range;
    })();
    UI.Range = Range;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Rating = (function () {
        function Rating(item) {
            var _this = this;
            this.move = function (e) {
                var value = Math.ceil((e.offsetX / _this.item.width()) * 10) / 2;
                _this.setHover(value);
            };
            this.click = function (e) {
                _this.move(e);
                $.post('/!Rating', {
                    'id': _this.item.attr('widget'),
                    'target': _this.item.attr('target'),
                    'value': _this.item.attr('rating-value')
                }, function (data) {
                    _this.item = _this.item.replaceWith(data);
                });
            };
            this.item = $(item);
            this.item.click(this.click);
            this.item.mousemove(this.move);
            this.item.mouseleave(function () {
                _this.setHover(0);
            });
        }
        Rating.prototype.setHover = function (value) {
            this.item.attr('rating-value', value).find('.hover').css('width', value * 20 + '%');
        };

        Rating.check = function () {
            return true;
        };
        return Rating;
    })();
    UI.Rating = Rating;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var SchemasInput = (function () {
        function SchemasInput(item) {
            var _this = this;
            this.onAdd = function (e) {
                var option = _this.select.find('option:selected');
                if (option.attr('disabled'))
                    return;
                var id = option.attr('value');
                option[0].selected = false;
                _this.select.find('option')[0].selected = true;
                _this.select.after($('<div/>', {
                    'qtype': 'SIPart'
                }).append([
                    $('<span/>', {
                        'text': option.text()
                    }),
                    $('<input/>', {
                        'type': 'hidden',
                        'name': _this.root.attr('name') + '[' + id + '][id]',
                        'value': id
                    }),
                    ($('<label/>', {
                        'text': _this.root.attr('data-required')
                    }).prepend($('<input/>', {
                        'type': 'checkbox',
                        'name': _this.root.attr('name') + '[' + id + '][required]',
                        'value': 1,
                        'text': 'Required'
                    }))),
                    ($('<label/>', {
                        'text': _this.root.attr('data-filter')
                    }).prepend($('<input/>', {
                        'type': 'checkbox',
                        'name': _this.root.attr('name') + '[' + id + '][filter]',
                        'value': 1,
                        'text': 'Required'
                    })))
                ]));
                option.remove();
            };
            this.onRemove = function (e) {
                var current = $(e.currentTarget).parent();
                _this.select.append($('<option>', {
                    'value': current.find('input[type="hidden"]').val(),
                    'text': current.contents()[0].textContent.trim()
                }));
                current.remove();
            };
            this.onEnter = function (e) {
                var current = $(e.currentTarget);
                current.append('<span qtype="remove"/>');
            };
            this.onLeave = function (e) {
                var current = $(e.currentTarget);
                current.find('[qtype="remove"]').remove();
            };
            this.root = $(item);
            this.select = this.root.find('select');
            this.select.change(this.onAdd);
            this.root.on('mouseenter', '[qtype="SIPart"]', this.onEnter);
            this.root.on('mouseleave', '[qtype="SIPart"]', this.onLeave);
            this.root.on('click', '[qtype="remove"]', this.onRemove);
        }
        SchemasInput.prototype.update = function () {
        };

        SchemasInput.check = function () {
            return true;
        };
        return SchemasInput;
    })();
    UI.SchemasInput = SchemasInput;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var StringList = (function () {
        function StringList(item) {
            var _this = this;
            this.onKeyPress = function (e) {
                //input chars
                var symb = String.fromCharCode(e.which);
                if (_this.root.attr('seporators').indexOf(symb) > -1) {
                    e.preventDefault();
                    var val = _this.input.val().substr(0, _this.input[0].selectionStart);
                    if (val.length) {
                        _this.value.before($('<span/>', {
                            'qtype': 'SLPart'
                        }).text(val));
                        _this.input.val(_this.input.val().substr(_this.input[0].selectionEnd));
                        _this.input[0].selectionStart = _this.input[0].selectionEnd = 0;
                    }
                    _this.update();
                } else if (e.keyCode == 32) {
                    e.preventDefault();
                    _this.input.val(_this.input.val() + '_');
                }
            };
            this.onKeyDown = function (e) {
                //backspace press after last symbol
                if (e.keyCode == 8 && _this.input[0].selectionStart == 0) {
                    var part = _this.root.find('[qtype="SLPart"]').last();
                    if (part) {
                        _this.input.val(part.text() + _this.input.val().substr(_this.input[0].selectionEnd));
                        _this.input[0].selectionStart = _this.input[0].selectionEnd = part.text().length;
                        part.remove();
                        e.preventDefault();
                    }
                }
            };
            this.onFocus = function (e) {
                var current = $(e.currentTarget);
                current.parent().attr('focus', 'focus');
                _this.update();
            };
            this.onBlur = function (e) {
                var current = $(e.currentTarget);
                current.parent().attr('focus', null);
                _this.update();
            };
            this.root = $(item);
            this.input = this.root.find('[qtype="SLInput"]');
            this.value = this.root.find('[qtype="SLValue"]');

            this.root.click(function (e) {
                _this.input.focus();
            });

            this.input.keydown(this.onKeyDown).keypress(this.onKeyPress).focus(this.onFocus).blur(this.onBlur);
        }
        StringList.prototype.update = function () {
            var value = '';
            var seporator = this.root.attr('seporators').substr(0, 1);
            this.root.find('[qtype="SLPart"]').each(function () {
                value += $(this).text() + seporator;
            });
            value += this.input.val();
            this.value.val(value);
        };

        StringList.check = function () {
            return true;
        };
        return StringList;
    })();
    UI.StringList = StringList;
})(UI || (UI = {}));
/// <reference path="../lib/jquery/jquery.d.ts" />
/// <reference path="ui.ts" />
var UI;
(function (UI) {
    var Url = (function () {
        function Url(item) {
            var _this = this;
            this.onKeyDown = function (e) {
                //backspace press after last symbol
                if (e.keyCode == 8 && _this.input[0].selectionStart == 0 && _this.root.attr('multypart') != null) {
                    var part = _this.root.find('[qtype="UrlPart"]').last();
                    if (part && !part.is('[static]')) {
                        _this.input.val(part.text() + _this.input.val().substr(_this.input[0].selectionEnd));
                        _this.input[0].selectionStart = _this.input[0].selectionEnd = part.text().length;
                        part.remove();
                        _this.update();
                        e.preventDefault();
                    }
                }
            };
            this.onKeyPress = function (e) {
                if (e.charCode == 47) {
                    e.preventDefault();
                    var val = _this.input.val().substr(0, _this.input[0].selectionStart);
                    if (val.length && _this.root.attr('multypart') != null) {
                        var part = _this.root.find('[qtype="UrlPart"]').last();
                        _this.value.before($('<span/>', {
                            'qtype': 'UrlPart'
                        }).text(val));
                        _this.input.val(_this.input.val().substr(_this.input[0].selectionEnd));
                        _this.input[0].selectionStart = _this.input[0].selectionEnd = 0;
                    }
                } else if (e.keyCode == 32) {
                    e.preventDefault();
                    _this.input.val(_this.input.val() + '_');
                }
                _this.update();
            };
            this.onFocus = function (e) {
                var current = $(e.currentTarget);
                current.parent().attr('focus', 'focus');
                _this.update();
            };
            this.onBlur = function (e) {
                var current = $(e.currentTarget);
                current.parent().attr('focus', null);
                _this.update();
            };
            this.onPaste = function (e) {
                _this.update();
                setTimeout(function () {
                    _this.input.val(slug(_this.input.val(), { replacement: '_' }));
                }, 0);
            };
            this.root = $(item);
            this.value = this.root.find('[qtype="UrlValue"]');
            this.input = this.root.find('[qtype="UrlInput"]');

            this.input.keydown(this.onKeyDown).keypress(this.onKeyPress).change(function () {
                _this.update();
            }).focus(this.onFocus).blur(this.onBlur).on('paste', this.onPaste);

            this.root.click(function (e) {
                _this.input.focus();
            });

            var refresh = this.root.find('[qtype="UrlRefresh"]');
            if (refresh.length > 0) {
                refresh.click(function (e) {
                    var source = _this.root.parents('form').first().find('#' + refresh.attr('data-id') + '');
                    if (source.length > 0)
                        _this.input.val(slug(source.val()));
                });
            }

            this.update();
            $(window).load(function () {
                _this.update();
            });
        }
        Url.prototype.update = function () {
            var url = '';
            if (this.root.attr('absolute') != null) {
                this.root.find('[qtype="UrlPart"]').each(function () {
                    url += '/' + $(this).text();
                });
                url += '/' + this.input.val();
            } else {
                this.root.find('[qtype="UrlPart"]').not('[static]').each(function () {
                    url += $(this).text() + '/';
                });
                url += this.input.val();
            }
            this.value.val(url);
        };

        Url.check = function () {
            return true;
        };
        return Url;
    })();
    UI.Url = Url;
})(UI || (UI = {}));
var UI;
(function (UI) {
    var Unload = (function () {
        function Unload() {
        }
        Unload.add = function (unload) {
            Unload.unloads.push(unload);
        };

        Unload.ckeck = function () {
            $(window).on('beforeunload', function (e) {
                var msgs = [];
                for (var i = 0; i < Unload.unloads.length; i++) {
                    var msg = Unload.unloads[i]();
                    if (typeof (msg) == 'String' && msgs.indexOf(msg) == -1)
                        msgs.push(msg);
                }
                if (msgs.length > 0)
                    return msgs.join('\n');
            });
        };
        Unload.unloads = [];
        return Unload;
    })();
    UI.Unload = Unload;
})(UI || (UI = {}));

$(function () {
    UI.Controll.init(document.body);
});
