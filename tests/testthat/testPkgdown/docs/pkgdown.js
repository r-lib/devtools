$(function() {

  $("#sidebar")
    .stick_in_parent({offset_top: 40})
    .on('sticky_kit:bottom', function(e) {
      $(this).parent().css('position', 'static');
    })
    .on('sticky_kit:unbottom', function(e) {
      $(this).parent().css('position', 'relative');
    });

  $('body').scrollspy({
    target: '#sidebar',
    offset: 60
  });

  $('[data-toggle="tooltip"]').tooltip();

  var cur_path = paths(location.pathname);
  $("#navbar ul li a").each(function(index, value) {
    if (value.text == "Home")
      return;
    if (value.getAttribute("href") === "#")
      return;

    var path = paths(value.pathname);
    if (is_prefix(cur_path, path)) {
      // Add class to parent <li>, and enclosing <li> if in dropdown
      var menu_anchor = $(value);
      menu_anchor.parent().addClass("active");
      menu_anchor.closest("li.dropdown").addClass("active");
    }
  });
});

function paths(pathname) {
  var pieces = pathname.split("/");
  pieces.shift(); // always starts with /

  var end = pieces[pieces.length - 1];
  if (end === "index.html" || end === "")
    pieces.pop();
  return(pieces);
}

function is_prefix(needle, haystack) {
  if (needle.length > haystack.lengh)
    return(false);

  // Special case for length-0 haystack, since for loop won't run
  if (haystack.length === 0) {
    return(needle.length === 0);
  }

  for (var i = 0; i < haystack.length; i++) {
    if (needle[i] != haystack[i])
      return(false);
  }

  return(true);
}

/* Clipboard --------------------------*/

function changeTooltipMessage(element, msg) {
  var tooltipOriginalTitle=element.getAttribute('data-original-title');
  element.setAttribute('data-original-title', msg);
  $(element).tooltip('show');
  element.setAttribute('data-original-title', tooltipOriginalTitle);
}

if(Clipboard.isSupported()) {
  $(document).ready(function() {
    var copyButton = "<button type='button' class='btn btn-primary btn-copy-ex' type = 'submit' title='Copy to clipboard' aria-hidden='true' data-toggle='tooltip' data-placement='left auto' data-trigger='hover' data-clipboard-copy><i class='fa fa-copy' aria-hidden='true'></i></button>";

    $(".examples").addClass("hasCopyButton");

    // Insert copy buttons:
    $(copyButton).prependTo(".hasCopyButton");

    // Initialize tooltips:
    $('.btn-copy-ex').tooltip({container: 'body'});

    // Initialize clipboard:
    var clipboardBtnCopies = new Clipboard('[data-clipboard-copy]', {
      text: function(trigger) {
        return trigger.parentNode.textContent;
      }
    });

    clipboardBtnCopies.on('success', function(e) {
      changeTooltipMessage(e.trigger, 'Copied!');
      e.clearSelection();
    });

    clipboardBtnCopies.on('error', function() {
      changeTooltipMessage(e.trigger,'Press Ctrl+C or Command+C to copy');
    });
  });
}

