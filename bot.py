import os
import telebot

# Бот будет искать секретную переменную с именем BOT_TOKEN в Render
TOKEN = os.environ.get('BOT_TOKEN')
bot = telebot.TeleBot(TOKEN)

# Простая база данных в памяти (словарь). 
# Ключ — ID пользователя, значение — количество еврокойнов.
users_db = {}

# Функция для определения звания в зависимости от баланса
def get_rank(coins):
    if coins >= 1000:
        return "Про еврооптер 🏆"
    elif coins >= 100:
        return "Опытный еврооптер"
    else:
        return "Еврооптер"

@bot.message_handler(commands=['start'])
def send_welcome(message):
    bot.reply_to(message, "Добро пожаловать в симулятор Евроопта! 🛒\nПиши /mamafarm, чтобы работать, и /balance, чтобы проверить свой счет.")

@bot.message_handler(commands=['mamafarm'])
def farm_coins(message):
    user_id = message.from_user.id
    
    # Если пользователя еще нет в нашей "базе", создаем ему счет с 0
    if user_id not in users_db:
        users_db[user_id] = 0
        
    # Выдаем зарплату
    users_db[user_id] += 1
    
    bot.reply_to(message, "Зарплата от Евроопта:\n+1 еврокойн 🪙")

@bot.message_handler(commands=['balance'])
def check_balance(message):
    user_id = message.from_user.id
    
    # Получаем баланс пользователя. Если его нет, то 0.
    coins = users_db.get(user_id, 0)
    rank = get_rank(coins)
    
    text = f"💼 Твой баланс: {coins} еврокойнов\n🎖 Твое звание: {rank}"
    bot.reply_to(message, text)

# Запускаем бота, чтобы он постоянно проверял новые сообщения
if __name__ == '__main__':
    print("Бот Евроопта успешно запущен!")
    bot.infinity_polling()
