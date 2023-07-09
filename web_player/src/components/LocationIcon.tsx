interface LocationIconProps {
  color: string;
}

const LocationIcon = ({ color }: LocationIconProps) => {
  return (
    <svg
      width="12"
      height="12"
      viewBox="0 0 12 12"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M10.9732 1.01342L1.03789 5.98106C1.02845 5.98577 1.03181 6 1.04236 6H5.99C5.99552 6 6 6.00448 6 6.01V10.9576C6 10.9682 6.01423 10.9715 6.01894 10.9621L10.9866 1.02683C10.9909 1.01824 10.9818 1.00912 10.9732 1.01342Z"
        stroke={color}
        stroke-width="1.4"
      />
    </svg>
  );
};

export default LocationIcon;
