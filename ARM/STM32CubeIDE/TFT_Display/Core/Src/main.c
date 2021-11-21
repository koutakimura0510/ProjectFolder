/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  * --SW--
  * PORTA PA0
  *
  * --PWM--
  * PORTA PA7
  *
  * --TFT--
  * RGB	: PA3 PA6 PA11 PA12
  * 		: PB0 PB1 PB8 PB9 PB10 PB11
  * 		: PC7 PC10
  * 		: PD3 PD6
  * 		: PG6 PG10 PG11 PG12
  *
  * ENABLE	: PF10
  * VSYNC	: PA4
  * HSYNC	: PC6
  * DOTCLK	: PG7
  *
  * CSX	: PC2
  * RDX	: PD12
  * TE		: PD11
  * WRX	: PD13
  * DCX	: PF7
  * SDA	:	/
  * --
  * PORTA PA3 PA4 PA6 PA11 PA12
  * PORTB PB0 PB1 PB8 PB9 PB10 PB11
  * PORTC PC2 PC6 PC7 PC10
  * PORTD PD3 PD6 PD11 PD12 PD13
  * PORTF PF7
  * PORTG PG6 PG7 PG10 PG11 PG12
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

#include "../Inc/MYLIB.h"

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

//TIM_HandleTypeDef ht

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
I2S_HandleTypeDef hi2s2;
DMA_HandleTypeDef hdma_spi2_tx;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_DMA_Init(void);
static void MX_I2S2_Init(void);
/* USER CODE BEGIN PFP */

void system_init(void);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/**-------------------------------------------------
 *  user init
 *  ------------------------------------------------
 *  SysTick Timer 割り込み周期計算
 *  周期 = (システムクロック / 設定する値) / システムクロック
 * -------------------------------------------------*/
void system_init(void)
{
	//PORTG 初期設定
	RCC->AHB1ENR   |= (RCC_AHB1ENR_GPIOGEN);	//PORTGのクロック有効
	GPIOG->MODER   &= ~GPIO_MODER_MODE13_Msk;	//PORTGを初期化
	GPIOG->MODER   |= (GPIO_MODE_OUTPUT_PP << GPIO_MODER_MODE13_Pos);	//13PINを汎用出力に設定
	GPIOG->OSPEEDR |= GPIO_SPEED_FREQ_HIGH;	//High speed
	GPIOG->PUPDR   &= ~GPIO_PUPDR_PUPD13_Msk;	//プルアップ、プルダウンなし
	GPIOG->ODR = GPIO_ODR_OD13;		//Hi出力

	// PORTA PA7 PWM_CH2 出力設定
	RCC->AHB1ENR   |= (RCC_AHB1ENR_GPIOAEN);
	GPIOA->MODER   &= ~GPIO_MODER_MODE7_Msk;
	GPIOA->MODER   |= GPIO_MODER_MODE7_1;	//オルタネート機能に設定
	GPIOA->OSPEEDR |= (GPIO_SPEED_FREQ_HIGH << GPIO_OSPEEDR_OSPEED7_Pos);
	GPIOA->PUPDR   &= ~GPIO_PUPDR_PUPD7_Msk;
	GPIOA->IDR     |= GPIO_IDR_IDR_7;
	GPIOA->AFR[0]  |= GPIO_AFRL_AFRL7_1;	//ペリフェラルPWM出力のためオルタネート機能有効

	//PA0　入力設定
	GPIOA->MODER &= ~GPIO_MODER_MODE0_Msk;
	GPIOA->PUPDR &= ~GPIO_PUPDR_PUPD0_Msk;	//外部プルアップを使用するため内部プルアップ停止

	tim2_init();
	tim3_init();
	tim7_init();
	i2s_dma_setting();
	//SysTick_Config(SystemCoreClock/10);
}



/*void SysTick_Handler(void)
{
	GPIOG->ODR ^= GPIO_ODR_OD13;
}*/



/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_DMA_Init();
  MX_I2S2_Init();
  /* USER CODE BEGIN 2 */

  uint32_t t;

  music_set_info(INADA);
  system_init();
  t = get_time();

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
	if (true == comparater_time(&t, TM_1SEC_COUNT, 'S')) {
		t = get_time();
		GPIOG->ODR ^= GPIO_ODR_OD13_Msk;
	}

	if (SW_BIT_SET == key_read()) {
	}
	music_update();
	monitoring_buffer();

    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInitStruct = {0};

  /** Configure the main internal regulator output voltage
  */
  __HAL_RCC_PWR_CLK_ENABLE();
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
  RCC_OscInitStruct.PLL.PLLM = 8;
  RCC_OscInitStruct.PLL.PLLN = 180;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 4;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Activate the Over-Drive mode
  */
  if (HAL_PWREx_EnableOverDrive() != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV4;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5) != HAL_OK)
  {
    Error_Handler();
  }
  PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_I2S;
  PeriphClkInitStruct.PLLI2S.PLLI2SN = 96;
  PeriphClkInitStruct.PLLI2S.PLLI2SR = 4;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief I2S2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_I2S2_Init(void)
{

  /* USER CODE BEGIN I2S2_Init 0 */

  /* USER CODE END I2S2_Init 0 */

  /* USER CODE BEGIN I2S2_Init 1 */

  /* USER CODE END I2S2_Init 1 */
  hi2s2.Instance = SPI2;
  hi2s2.Init.Mode = I2S_MODE_MASTER_TX;
  hi2s2.Init.Standard = I2S_STANDARD_MSB;
  hi2s2.Init.DataFormat = I2S_DATAFORMAT_16B_EXTENDED;
  hi2s2.Init.MCLKOutput = I2S_MCLKOUTPUT_DISABLE;
  hi2s2.Init.AudioFreq = I2S_AUDIOFREQ_32K;
  hi2s2.Init.CPOL = I2S_CPOL_HIGH;
  hi2s2.Init.ClockSource = I2S_CLOCK_PLL;
  hi2s2.Init.FullDuplexMode = I2S_FULLDUPLEXMODE_DISABLE;
  if (HAL_I2S_Init(&hi2s2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN I2S2_Init 2 */

  /* USER CODE END I2S2_Init 2 */

}

/**
  * Enable DMA controller clock
  */
static void MX_DMA_Init(void)
{

  /* DMA controller clock enable */
  __HAL_RCC_DMA1_CLK_ENABLE();

  /* DMA interrupt init */
  /* DMA1_Stream4_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(DMA1_Stream4_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(DMA1_Stream4_IRQn);

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
