import consumer from "./consumer"

document.getElementById("roll-dice-btn").addEventListener("click", () => {
  consumer.subscriptions.create({ channel: "GameChannel", game_id: GAME_ID }, {
    received(data) {
      // サイコロの結果をUIに反映
      document.getElementById("dice-result").innerText = data.dice_result;
    },
    rollDice() {
      this.perform("roll_dice", { game_id: GAME_ID, player_id: PLAYER_ID });
    }
  }).rollDice();
});
