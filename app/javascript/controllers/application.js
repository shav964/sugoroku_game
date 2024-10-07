import { Application } from "@hotwired/stimulus";

// ここで consumer をインポート
import consumer from "../channels/consumer"; // channels フォルダから相対パスでインポート

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
