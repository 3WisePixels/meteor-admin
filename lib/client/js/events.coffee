Template.AdminLayout.events
	'click .btn-delete': (e,t) ->
		_id = $(e.target).attr('doc')
		if Session.equals 'admin_collection_name', 'Users'
			Session.set 'admin_id', _id
			Session.set 'admin_doc', Meteor.users.findOne(_id)
		else
			Session.set 'admin_id', parseID(_id)
			Session.set 'admin_doc', adminCollectionObject(Session.get('admin_collection_name')).findOne(parseID(_id))
			
	'click .check': (e,t) ->
		_id = $(e.target).attr('doc')
		checked_items = Session.get 'checked_items'
		checked = $(e.target).is(":checked")
		if(checked)
			checked_items.push _id
			Session.set 'checked_items', checked_items
		else
			index = checked_items.indexOf _id
			checked_items.splice(index,1)
			Session.set 'checked_items', checked_items
		console.log Session.get 'checked_items'
	'click th': (e,t) ->
		Session.set 'checked_items', []

Template.AdminDeleteModal.events
	'click #confirm-delete': () ->
		collection = Session.get 'admin_collection_name'
		_id = Session.get 'admin_id'
		Meteor.call 'adminRemoveDoc', collection, _id, (e,r)->
			$('#admin-delete-modal').modal('hide')

Template.AdminDashboardUsersEdit.events
	'click .btn-add-role': (e,t) ->
		console.log 'adding user'
		Meteor.call 'adminAddUserToRole', $(e.target).attr('user'), $(e.target).attr('role')
	'click .btn-remove-role': (e,t) ->
		console.log 'removing user'
		Meteor.call 'adminRemoveUserToRole', $(e.target).attr('user'), $(e.target).attr('role')

Template.AdminHeader.events
	'click .btn-sign-out': () ->
		Meteor.logout ->
			Router.go(AdminConfig?.logoutRedirect or '/')
