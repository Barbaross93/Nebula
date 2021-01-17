function updateTime() {
	var
		now = new Date(),
		hours = now.getHours(),
		minutes = now.getMinutes();
	hours = (((hours < 10) ? '0' : '') + hours);
	minutes = (((minutes < 10) ? '0' : '') + minutes);
	document.getElementById('time').textContent = hours + ':' + minutes;
}

setInterval(updateTime, 500);
