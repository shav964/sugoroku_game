// app/javascript/channels/game_channel.js
import consumer from "./consumer";

document.addEventListener('DOMContentLoaded', () => {
  consumer.subscriptions.create("GameChannel", {
    connected() {
      console.log("Connected to GameChannel");
    },

    disconnected() {
      console.log("Disconnected from GameChannel");
    },

    received(data) {
      // ブロードキャストされたデータを受け取り、画面を更新
      const playerId = data.player_id;
      const newPosition = data.new_position;
      const diceResult = data.dice_result;
      const playerName = data.player_name;

      // プレイヤーの位置を更新
      const playerRow = document.querySelector(`[data-player-id='${playerId}']`);
      if (playerRow) {
        playerRow.querySelector('.position').innerText = `${newPosition} / 20`;
      }

      // コマの位置を更新
      const playerPiece = document.querySelector(`.player-${playerId}`);
      if (playerPiece) {
        playerPiece.style.left = `${newPosition * 50}px`;  // 例: マスの幅が50pxの場合
      }

      // メッセージの表示（任意）
      alert(`${playerName}がサイコロを振って${diceResult}が出ました！`);
    }
  });
});
