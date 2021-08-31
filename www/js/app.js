$(document).foundation();

$(document)
  // field element is invalid
  .on('invalid.zf.abide', function(ev, elem) {
    // console.log("Field id "+ev.target.id+" is invalid");
  })
  // field element is valid
  .on('valid.zf.abide', function(ev, elem) {
    // console.log("Field name "+elem.attr('name')+" is valid");
  })
  // form validation failed
  .on('forminvalid.zf.abide', function(ev, frm) {
    // console.log("Form id "+ev.target.id+" is invalid");
  })
  // form validation passed, form will submit if submit event not returned false
  .on('formvalid.zf.abide', function(ev, frm) {
    // console.log("Form id " + frm.attr('id') + " is valid")
    const action = frm.attr('action');

    const form = frm;
    $(frm)
      .find('[type=submit]')
      .prop('disabled', true);

    apiSender(frm.attr('action') + '.json', frm[0])
      .then((response) => {
        if (response.status != 200) location.reload();
        return response.json();
      })
      .then((json) => {
        console.log(1, action);
        switch (action) {
          case '/user/login':
            json.user ? location.reload() : console.log('login', json);

            if (json.error)
              $(frm)
                .find('[type=submit]')
                .prev('.server-error')
                .addClass('show')
                .text(json.error);

            $(frm)
              .find('[type=submit]')
              .prop('disabled', false);

            break;
          case '/user/register':
            console.log('registration', json);
            if (json.user) {
              var userEmail = $('#singUp')
                .find('input[type=email]')
                .val();
              $('#confirmMailCode').foundation('open');
              $('#confirmMailCode')
                .find('[name=email]')
                .val(userEmail);
            }
            if (json.error)
              $(frm)
                .find('[type=submit]')
                .prev('.server-error')
                .addClass('show')
                .text(json.error);

            $(frm)
              .find('[type=submit]')
              .prop('disabled', false);
            break;
          case '/user/restore':
            frm
              .parent()
              .siblings('.modal-subtitle')
              .css('marginBottom', 0)
              .find('.or')
              .html(
                'Ссылка восстановления пароля отправлена на email <b>' +
                  json.email +
                  '</b>'
              );
            frm.parent().remove();
            console.log('restore pass', json);
            break;
          case '/user/confirm':
            if (json.result) {
              $('#cRules').foundation('open');
            } else {
              $(frm)
                .find('.form-error')
                .text(json.error)
                .addClass('is-visible');
              $(frm)
                .find('label')
                .addClass('is-invalid-label');
              $(frm)
                .find('[name=code]')
                .addClass('is-invalid-input');
            }
            $(frm)
              .find('[type=submit]')
              .prop('disabled', false);
            break;
          case '/participate':
            location.reload();
            break;
          default:
            console.log('default', json);
        }
      })
      .catch(function(error) {
        console.log(error);
      });
  });

window.VoteData = {
  el: null,
  vote: null,
  set(elem) {
    this.el = elem.currentTarget;
    this.vote = $(this.el).data('vote');
    $('#votePopup').foundation('open');
  },
  submit() {
    var target = this,
      voteInforer = $('[vote-card-informer=' + this.vote + ']'),
      countVotes = parseInt(voteInforer.text());

    if (this.vote) {
      $('#submitVote').prop('disabled', true);
      fetch('/vote/' + this.vote + '.json')
        .then((response) => response.json())
        .then((json) => {
          console.log(json.votes_left);
          $('[data-informer=votesLeft]').text(json.votes_left);

          if (json.can_vote_again) {
            $(target.el)
              .removeClass('hollow')
              .html('<i class="fi fi-thumbs-up-solid"></i> Ваш голос учтен');
            setTimeout(() => {
              $(target.el).html(
                '<i class="fi fi-thumbs-up-solid"></i> Проголосовать еще'
              );
            }, 3000);
          } else {
            $(target.el)
              .removeClass('hollow')
              .prop('disabled', true)
              .html('<i class="fi fi-thumbs-up-solid"></i> Ваш голос учтен');
          }

          $('#votePopup').foundation('close');
          $('#submitVote').prop('disabled', false);
          voteInforer.text(countVotes + 1);
          target.clear();
        })
        .catch(function(error) {
          console.log(error);
        });
    }
  },
  clear() {
    if (this.vote) {
      // console.log('голоса очищены')
      $('#submitVote').prop('disabled', false);
      this.vote = null;
    }
  },
};

$('.logotype-click').click(() => {
  const url = window.location.origin;
  window.location.replace(url);
});

$('[action-vote]').click(function(e) {
  VoteData.set(e);
});

$('#submitVote').click(() => {
  VoteData.submit();
});

$('#uploadInput').change(function() {
  readURL(this);
});

$('form.action-submit').on('submit', function(ev) {
  ev.preventDefault();
  console.log('Submit for form id ' + ev.target.id + ' intercepted');
});

window.cardsConfirm = {
  storeName: 'voteCards',
  url: '',
  cards: [],
  init() {
    if (sessionStorage.getItem(this.storeName))
      this.cards = JSON.parse(sessionStorage.getItem(this.storeName));

    $.each(this.cards, (index, item) =>
      $('[data-bookmark=' + item + ']').addClass('added')
    );

    this.url = JSON.stringify(this.cards)
      .replace('[', '')
      .replace(']', '');
    if (this.url.length > 0) {
      $('[data-informer=mychoice]').attr('href', '/mychoice/' + this.url);
    } else {
      $('[data-informer=mychoice]').attr('href', '/mychoice');
    }

    var counter = this.cards.length ? ' (' + this.cards.length + ')' : '';

    $('[data-informer=mychoice]').html('Мой выбор' + '<b>' + counter + '</b>');
  },
  set(id, elem) {
    const index = this.cards.indexOf(id);
    if (index < 0) {
      if (this.cards.length < 10) {
        this.cards.push(id);
        elem.addClass('added');
      } else {
        alert('В сравнение можно добавить 10 фотографий');
      }
    } else {
      this.cards.splice(index, 1);
      if (elem) elem.removeClass('added');
    }
    sessionStorage.setItem(this.storeName, JSON.stringify(this.cards));
    this.init();
  },
};
cardsConfirm.init();

$('[data-bookmark]').click(function(e) {
  e.preventDefault();

  var target = $(this),
    targetID = target.data('bookmark');

  if (target.attr('delete')) {
    var confirmChoice = confirm('Подтвердить удаление?');
    if (confirmChoice) {
      cardsConfirm.set(targetID);
      var pageUrl =
        window.location.origin +
        '/mychoice/' +
        sessionStorage
          .getItem('voteCards')
          .replace('[', '')
          .replace(']', '');
      window.history.replaceState({}, 'Конкурс | СРавнение', pageUrl);
      target
        .closest('.card')
        .parent('.cell')
        .remove();
    }
  } else {
    cardsConfirm.set(targetID, target);
  }
});

var testForm = new FormData();
testForm.append('reg[name_name]', 'Test');
testForm.append('reg[email]', '');
testForm.append('reg[password]', 'qwerty123');
testForm.append('reg[confirm]', 'qwerty123');

async function apiSender(url, form, test = false) {
  var formData = new FormData(form);
  if (test) {
    console.log('');
    formData = form;
  }

  const method = $(form).attr('method') || 'POST';

  if (method == 'GET') {
    const response = await fetch(url + '?' + $(form).serialize(), {
      method: method,
      credentials: 'include',
      redirect: 'manual',
    });
    return await response;
  }

  if (method == 'POST') {
    const response = await fetch(url, {
      method: method,
      credentials: 'include',
      body: formData,
      redirect: 'manual',
    });
    return await response;
  }
}

var _URL = window.URL || window.webkitURL;
function readURL(input) {
  const maxwidth = 640;
  const maxheight = 480;
  var height = 0;
  var width = 0;
  var file, img;

  if (input.files && input.files.length > 0) {
    const image = input.files[0];
    const imegeName = mekeRandomeName(image.name);

    img = new Image();
    img.onload = function() {
      if (this.width < maxwidth || this.height < maxheight) {
        alert(
          'Размер изображения должен быть не меньше ' +
            maxwidth +
            'x' +
            maxheight +
            'px'
        );
      } else {
        uploadImage(imegeName, image);
      }
    };
    img.onerror = function() {
      alert('not a valid file: ' + image.type);
    };
    img.src = _URL.createObjectURL(image);
  }
}

function uploadImage(imegeName, image) {
  $('.drag-drop-block').addClass('uploading');
  fetch('/upload/' + imegeName, {
    method: 'PUT',
    credentials: 'include',
    headers: {
      'x-requested-with': 'XMLHttpRequest',
    },
    body: image,
  })
    .then((response) => {
      console.log(response);
      return response.json();
    })
    .then((json) => {
      const form = new FormData();
      const url = '/upload' + json.file.path + '/' + json.file.name;

      form.append('4:#11[url]', url);
      form.append('ref[]', 'picture[image]');

      fetch('/picture.json', {
        method: 'POST',
        credentials: 'include',
        redirect: 'manual',
        body: form,
      })
        .then((response) => response.text())
        .then((json) => {
          console.log(json);
          $('.drag-drop-block').removeClass('uploading');
          $('.upload-btn-wrapper > .dd-title')
            .text('Фото успешно загружено')
            .siblings()
            .remove();
          setTimeout(() => {
            location.reload();
          }, 1500);
        })
        .catch((error) => console.log(error));
    })
    .catch((error) => console.log(error));
}

function mekeRandomeName(imageName) {
  const first = Math.random();
  const second = Math.random();
  const extension = imageName.split('.').pop();
  first.toString(36);
  second.toString(36);
  const newName =
    first.toString(36).substr(2, 9) +
    second.toString(36).substr(2, 9) +
    '.' +
    extension;
  return newName;
}

$(function() {
  //Check to see if the window is top if not then display button
  $(window).scroll(function() {
    if ($(this).scrollTop() > 5) {
      // 300px from top
      $('#srollButton').fadeIn(800);
      console.log('show');
    } else {
      $('#srollButton').fadeOut(800);
      console.log('hide');
    }
  });
});
