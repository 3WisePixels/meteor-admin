Template.AdminLayout.events({
  "click #apply_filter": function(e, t) {
    let val = $("#status_value").val();
    checked_items = Session.get("checked_items");

    if (!val) {
      return;
    }

    if (checked_items.length > 0) {
      // pull out all docs and maek changes to them
      let res = confirm("Are you sure you perform this action");
      if (res == true) {
        checked_items.forEach((item) => {
          Orders.update({ _id: item }, { $set: { status: val } });
        });
        Session.set("checked_items", []);
      }
    } else {
      alert("Please select an item(s) to perform an action");
    }
  }
});

