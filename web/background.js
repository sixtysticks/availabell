var popupWindowId = false;

chrome.browserAction.onClicked.addListener(function(activeTab){
	const popupUrl = chrome.extension.getURL('index.html');
	const width = 300;
	const height = 500;

	if (popupWindowId === false) {
		popupWindowId = true;
		chrome.windows.create({
			'url': popupUrl,
			'type': 'popup',
			'height': height,
			'width': width,
			'left': (screen.width) - (width) - 9,
			'top': 33,
			'focused': true
		}, function(win) {
			popupWindowId = win.id;
		});
		return;
	} else if(typeof popupWindowId === 'number'){
		//The window is open, and the user clicked the button.
		//  Focus the window.
		chrome.windows.update(popupWindowId,{focused:true});
	}
});

chrome.windows.onRemoved.addListener(function (winId){
	if(popupWindowId === winId){
			popupWindowId = false;
	}
});