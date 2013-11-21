define [
	"jquery"
], ($) ->

	class Popup

		_query : 'broken tent' # Flickr search term
		_photos : null

		constructor: ->

			console.log 'Running Popup...'

			@_getPhotos()

		_getPhotos: ->

			# build the Flickr API request URL - encoding the search term. JSON callback set to no to return raw JSON
			url = 'https://secure.flickr.com/services/rest/?method=flickr.photos.search&format=json&api_key=d54e08aa66cbb8297a16758b1ea911be&text='+encodeURIComponent(@_query)+'&safe_search=1&content_type=1&sort=relevance&per_page=40&nojsoncallback=1'

			req = new XMLHttpRequest() # create new XHR
			req.open "GET", url, true # set type and url
			req.onload = @_loadPhotos # run _loadPhotos on success
			req.send null # send request

		_loadPhotos: (e) ->

			@_photos = JSON.parse e.target.response # parse the raw JSON string to create a JS object

			photos = @_photos.photos.photo # access array of photos

			for i in [0...photos.length]
				# set Flickr ids
				farmId = photos[i].farm
				serverId = photos[i].server
				photoId = photos[i].id
				secret = photos[i].secret
				# construct img src
				src = "http://farm#{farmId}.staticflickr.com/#{serverId}/#{photoId}_#{secret}.jpg"
				
				# create new img element, set src attribute and append to DOM
				img = $('<img>', {src:src})
				$('.photos').append img
