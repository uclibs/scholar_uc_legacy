var togglePublisherRequirement = function() {
  // When the DOI form is changed
  $('.set-doi').change(function() {
    var target = $("div[class*='form-group'][class*='publisher']")
    var label = target.children().filter("label");
    var input = target.children().filter("ul").children().children().first();
    var mint_doi_checked = $("#mint-doi").is(':checked');

    function add_requirement_notice() {
      var target = $('#mint-doi').siblings().first();
      var notice = '<span id="publisher-label" class="label label-info">Please add a publisher on the Descriptions tab </span>';

      function need_to_add_notice() {
        var field = $('input[class*=publisher]').first();

        // if the notice isn't there, and the publisher is blank, we need to add it
        if ( ($('#publisher-label').length == 0) && (field.val() == "") ) {
          return true;
        } else {
          return false;
        }
      }

      if (need_to_add_notice()) {
        target.after(notice);
      }
    }

    function add_and_remove_field(target) {
      // add and remove a publisher field to trigger the save work requirements tracking
      // if we want to stop doing this, we need to override the following:
      // hyrax/app/assets/javascripts/hyrax/save_work/save_work_control.es6
      // so that this.formChanged() gets called when the DOI form is updated

      var field = $('input[class*=publisher]').last()

      if (field.val() == "") {
        //if publisher is blank - fill it, add the field, remove it, empty it
        // fill it
        field.val("Test");

        // click add
        target.children().filter("button").click();
        // click remove
        var new_field = $('input[class*=publisher]').last();
        var button = new_field.next().children();
        button.click();

        // empty the field
        field.val("");
      } else {
        // if publisher is not blank, add the field, remove it
        // click add
        target.children().filter("button").click();
        // click remove
        var new_field = $('input[class*=publisher]').last();
        var button = new_field.next().children();
        button.click();
      }
    }

    if (mint_doi_checked) {
      add_requirement_notice(target);

      // If we want one, add the things
      target.switchClass("optional", "required");
      label.switchClass("optional", "required");
      label.html("Publisher <span class='label label-info required-tag'>required</span>");
      input.switchClass("optional", "required");
      input.attr("required", "required");
      input.attr("aria-required", "true");

      add_and_remove_field(target);
    } else {
      // If we don't want one, remove the things
      target.switchClass("optional", "required");
      label.switchClass("optional", "required");
      label.html("Publisher");
      input.switchClass("optional", "required");
      input.removeAttr("required");
      input.removeAttr("aria-required");

      // add and remove a publisher field to trigger the save work requirements tracking
      add_and_remove_field(target);
    }
  });
}

$(document).on('turbolinks:load', togglePublisherRequirement)
