import subprocess
import sys


def install_requirements():
  modules = ['requests', 'pygame-ce', 'pygame']

  print('Обновление pip...')
  subprocess.check_call(
      [sys.executable, '-m', 'pip', 'install', '--upgrade', 'pip']
  )

  print('Установка модулей...')
  for module in modules:
    print(f'Установка {module}...')
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', module])


if __name__ == '__main__':
  install_requirements()
