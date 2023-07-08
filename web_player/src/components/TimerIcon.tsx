interface TimerIconProps {
  color: string;
}

const TimerIcon = ({ color }: TimerIconProps) => {
  return (
    <svg
      width="12"
      height="12"
      viewBox="0 0 12 12"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M6.47458 3.24746V2.11649C8.41414 2.34993 9.89468 3.99379 9.89468 5.99758C9.89468 8.1563 8.16534 9.89952 5.99758 9.89952C3.83443 9.89952 2.09584 8.15614 2.10048 5.99794C2.10523 5.06896 2.43061 4.20676 2.97669 3.54299L2.97682 3.5431L2.98021 3.53846C3.07976 3.40224 3.14352 3.25394 3.14864 3.10407C3.15386 2.95096 3.09738 2.80613 2.97501 2.68376C2.85028 2.55903 2.68529 2.50072 2.51796 2.51849C2.35133 2.53619 2.19032 2.62823 2.06718 2.78891C1.34364 3.66567 0.9 4.78445 0.9 5.99758C0.9 8.80287 3.197 11.1 5.99758 11.1C8.80293 11.1 11.1 8.80293 11.1 5.99758C11.1 3.19713 8.80783 0.9 6.00242 0.9C5.83258 0.9 5.68721 0.951108 5.58439 1.05549C5.48182 1.15962 5.43359 1.30458 5.43359 1.46883V3.24746C5.43359 3.54316 5.64652 3.78729 5.95408 3.78729C6.26165 3.78729 6.47458 3.54316 6.47458 3.24746ZM6.84517 6.81387L6.84524 6.81395L6.84851 6.81049C7.06531 6.58047 7.15577 6.30356 7.12142 6.03562C7.08716 5.76839 6.9302 5.52082 6.67282 5.34481C6.67278 5.34477 6.67273 5.34474 6.67268 5.34471L4.21757 3.65803L4.21758 3.65802L4.21642 3.65725C4.03723 3.53779 3.84039 3.55775 3.71998 3.67993C3.59997 3.80171 3.58159 3.99902 3.70075 4.17775L3.70074 4.17776L3.70158 4.17898L5.38794 6.62879C5.38802 6.6289 5.38809 6.62901 5.38817 6.62913C5.56386 6.88855 5.81106 7.04812 6.07709 7.08446C6.34419 7.12094 6.61947 7.03161 6.84517 6.81387Z"
        fill={color}
        stroke={color}
        stroke-width="0.2"
      />
    </svg>
  );
};

export default TimerIcon;