package util;

class DtTimer
{
	private var countdownMs:Int;
	private var running:Bool = false;

	private var callback:Void -> Void;

	public function new() {

	}

	public function setCallback(_callback:Void -> Void) {
		callback = _callback;
	}

	public function startWithCountdownMs(ms:Int) {
		countdownMs = ms;
		running = true;
	}

	public function step(dt:Int) {
		if (!running) return;

		countdownMs -= dt;

		if (countdownMs <= 0) {
			stop();
			callback();
		}
	}

	public function stop() {
		running = false;
	}

	public function getCountdownMs() {
		return countdownMs;
	}
}